import SwiftUI
import HealthKit

struct IntelligenceView: View {
    @State private var meditationMinutes: Double = 0
    let healthStore = HKHealthStore()
    
    @Environment(\.dismiss) private var dismiss

    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
            
            PixelIconView(iconName: "book", primaryColor: .blue)
                    .padding(.bottom, 15)
                    .padding(.top, 80)
            
            PixelLetterView(text: "M E D I T A T I O N", primaryColor: .white, backgroundColor: .black)
                    .padding(.bottom, 30)
                
                HStack {
                    PixelLetterView(
                        text: "P L E I N E   C O N S C I E N C E",
                        primaryColor: .white,
                        backgroundColor: .black
                    ).opacity(0.5)
                    Spacer()
                    PixelLetterView(text: "\(formatNumber(Int(meditationMinutes)))", primaryColor: .blue, backgroundColor: .black)
                    PixelLetterView(text: "M I N", primaryColor: .blue, backgroundColor: .black)
                        .opacity(0.5)
                }
                .padding().padding(.horizontal, 40)
            }
            .padding(.bottom, 60) // Ajoute de l'espace pour le menu
        }
        .safeAreaInset(edge: .bottom) {
            // Menu en bas
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    VStack {
                        Spacer()
                        PixelIconView(iconName: "arrow").opacity(0.5)
                    }
                }
                Spacer()
            }
            .padding()
        }
    .navigationBarHidden(true)
        .onAppear(perform: fetchMeditationTime)
    }
    
    func formatNumber(_ number: Int) -> String {
        return String(number).map { String($0) }.joined(separator: " ")
    }
    
    func fetchMeditationTime() {
        let meditationType = HKCategoryType.categoryType(forIdentifier: .mindfulSession)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKSampleQuery(sampleType: meditationType, predicate: predicate, limit: 0, sortDescriptors: nil) { _, results, _ in
            guard let results = results as? [HKCategorySample] else { return }
            let totalMeditationTime = results.reduce(0) { (sum, sample) -> Double in
                return sum + sample.endDate.timeIntervalSince(sample.startDate) / 60.0
            }
            self.meditationMinutes = totalMeditationTime
        }

        healthStore.execute(query)
    }
}

#Preview {
    IntelligenceView().preferredColorScheme(.dark)
}
