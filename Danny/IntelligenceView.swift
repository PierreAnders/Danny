import SwiftUI
import HealthKit

struct IntelligenceView: View {
    @State private var meditationMinutes: Double = 0
    let healthStore = HKHealthStore()
    
    var body: some View {
        VStack {
            
            PixelIconView(iconName: "book", primaryColor: .blue)
            
            PixelLetterView(text: "T E M P S   D E   M E D I T A T I O N", primaryColor: .white, backgroundColor: .black)
                .padding()
            
            PixelLetterView(text: "\(formatNumber(Int(meditationMinutes))) M I N", primaryColor: .white, backgroundColor: .black)
                           .padding()
            
            Spacer()
        }
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
    IntelligenceView()
}
