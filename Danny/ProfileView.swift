import SwiftUI
import HealthKit

struct ProfileView: View {
    @AppStorage("userName") var userName: String = ""
    @State private var intelligence: Double = 0
    @State private var energy: Double = 0
    @State private var force: Double = 0
    @State private var constitution: Double = 0
    @State private var agility: Double = 0

    let healthStore = HKHealthStore()

    let stepGoal: Double = 6000
    let sleepGoal: Double = 7 * 60
    let activeCaloriesGoal: Double = 500
    let basalCaloriesGoal: Double = 1500
    let mindfulMinutesGoal: Double = 20

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 20) {
                HStack {
                    NavigationLink(destination: NameCreationView()) {
                        HStack(spacing: 8) {
                            PixelFoxView(iconName: "fox") // .frame(width: 40, height: 40)
                            PixelLetterView(text: userName.isEmpty ? "D A N N Y" : userName.uppercased(), primaryColor: .white)
                                .opacity(0.5)
                                .padding()
                        }
                    }
                    Spacer().frame(width: 25)
                    VStack {
                        PixelLetterView(text: "N I V   8", primaryColor: .brown)
                    }
                }
                .padding(.top, 100)

                VStack(spacing: 15) {
                    NavigationLink(destination: AgilityView()) {
                                        ProgressRow(
                                            symbolText: "boot",
                                            characteristicName: "E x p l o r a t i o n",
                                            value: Int(agility),
                                            goal: Int(stepGoal),
                                            unit: "P A S",
                                            primaryColor: .yellow
                                        )
                                    }

                                    NavigationLink(destination: VitalityView()) {
                                        ProgressRow(
                                            symbolText: "heart",
                                            characteristicName: "V i t a l i t e",
                                            value: Int(constitution),
                                            goal: Int(basalCaloriesGoal),
                                            unit: "K C A L",
                                            primaryColor: .green
                                        )
                                    }

                                    NavigationLink(destination: StrengthView()) {
                                        ProgressRow(
                                            symbolText: "hand",
                                            characteristicName: "F o r c e",
                                            value: Int(force),
                                            goal: Int(activeCaloriesGoal),
                                            unit: "K C A L",
                                            primaryColor: .orange
                                        )
                                    }

                                    NavigationLink(destination: IntelligenceView()) {
                                        ProgressRow(
                                            symbolText: "book",
                                            characteristicName: "M e d i t a t i o n",
                                            value: Int(intelligence),
                                            goal: Int(mindfulMinutesGoal),
                                            unit: "M I N",
                                            primaryColor: .blue
                                        )
                                    }

                                    NavigationLink(destination: EnergyView()) {
                                        ProgressRow(
                                            symbolText: "lightning",
                                            characteristicName: "R e p o s",
                                            value: Int(energy),
                                            goal: Int(sleepGoal),
                                            unit: "M I N",
                                            primaryColor: .purple
                                        )
                                    }
                }
                .padding(.top, 50)
            }
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
        .padding(.horizontal, 40)
        .navigationBarHidden(true)
        .onAppear(perform: requestHealthData)
    }
    
    func requestHealthData() {
        let typesToRead = Set([
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.categoryType(forIdentifier: .mindfulSession)!,
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .basalEnergyBurned)!,
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        ])
        
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { success, error in
            if success {
                fetchHealthData()
            } else if let error = error {
                print("Erreur lors de la demande d'autorisation : \(error.localizedDescription)")
            }
        }
    }

    func fetchHealthData() {
        fetchActiveCalories()
        fetchMindfulMinutes()
        fetchStepCount()
        fetchBasalCalories()
        fetchSleepMinutes()
    }

    func fetchActiveCalories() {
        let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: calorieType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            if let result = result, let sum = result.sumQuantity() {
                DispatchQueue.main.async {
                    self.force = sum.doubleValue(for: .kilocalorie())
                }
            }
        }
        healthStore.execute(query)
    }

    func fetchSleepMinutes() {
        let sleepAnalysis = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKSampleQuery(sampleType: sleepAnalysis, predicate: predicate, limit: 0, sortDescriptors: nil) { _, samples, error in
            guard let samples = samples as? [HKCategorySample] else { return }
            DispatchQueue.main.async {
                self.energy = samples.reduce(0.0) { sum, sample in sum + sample.endDate.timeIntervalSince(sample.startDate) / 60.0 }
            }
        }
        healthStore.execute(query)
    }

    func fetchMindfulMinutes() {
        let mindfulType = HKCategoryType.categoryType(forIdentifier: .mindfulSession)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKSampleQuery(sampleType: mindfulType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, samples, error in
            guard let samples = samples as? [HKCategorySample] else { return }
            DispatchQueue.main.async {
                self.intelligence = samples.reduce(0.0) { sum, sample in sum + sample.endDate.timeIntervalSince(sample.startDate) / 60.0 }
            }
        }
        healthStore.execute(query)
    }

    func fetchStepCount() {
        let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            if let result = result, let sum = result.sumQuantity() {
                DispatchQueue.main.async {
                    self.agility = sum.doubleValue(for: .count())
                }
            }
        }
        healthStore.execute(query)
    }

    func fetchBasalCalories() {
        let basalCalorieType = HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: basalCalorieType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            if let result = result, let sum = result.sumQuantity() {
                DispatchQueue.main.async {
                    self.constitution = sum.doubleValue(for: .kilocalorie())
                }
            }
        }
        healthStore.execute(query)
    }
}

struct ProgressRow: View {
    var symbolText: String
    var characteristicName: String
    var value: Int
    var goal: Int
    var unit: String
    var primaryColor: Color
    
    var progress: CGFloat {
        min(CGFloat(value) / CGFloat(goal), 1.0)
    }

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                PixelIconView(iconName: symbolText, primaryColor: primaryColor)
                    .frame(width: 40, height: 40)
                PixelLetterView(text: characteristicName.uppercased()).opacity(0.5)
                Spacer()
                PixelLetterView(text: "\(value)", primaryColor: primaryColor)
                PixelLetterView(text: "/\(goal) \(unit)", primaryColor: primaryColor).opacity(0.3)
            }
            PixelProgressBarView(progress: progress, primaryColor: primaryColor)
        }
        .padding(.bottom, 10)
    }
}



struct PixelProgressBarView: View {
    let pixelSize: CGFloat = 3.0 // Taille des pixels
    let spacing: CGFloat = 0.5 // Espacement entre les pixels
    let totalPixels: Int = 100 // Nombre total de pixels pour une barre plus longue
    var progress: CGFloat // Progression entre 0 et 1
    var primaryColor: Color = .white
    var backgroundColor: Color = .gray.opacity(0.3) // Couleur de fond pour les pixels non remplis
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<totalPixels, id: \.self) { index in
                Rectangle()
                    .fill(index < Int(progress * CGFloat(totalPixels)) ? primaryColor : backgroundColor)
                    .frame(width: pixelSize, height: pixelSize)
            }
        }
    }
}


//import SwiftUI
//import HealthKit
//
//struct ProfileView: View {
//    @AppStorage("userName") var userName: String = "" // Récupère le nom sauvegardé ou vide par défaut
//    @State private var intelligence: Double = 0 // Minutes de respiration (mindful sessions)
//    @State private var energy: Double = 0 // Minutes de sommeil
//    @State private var force: Double = 0 // Calories actives
//    @State private var constitution: Double = 0 // Calories basales
//    @State private var agility: Double = 0 // Nombre de pas
//    
//    let healthStore = HKHealthStore()
//
//    // Ajout de l'action dismiss dans l'environnement
//    @Environment(\.dismiss) private var dismiss
//
//    var body: some View {
//        VStack(spacing: 20) {
//            VStack(spacing: 20) {
//                HStack {
//                    NavigationLink(destination: NameCreationView()) {
//                        HStack(spacing: 8) {
//                            PixelHeadView().frame(width: 40, height: 40)
//                            PixelLetterView(text: userName.isEmpty ? "D A N N Y" : userName.uppercased(), primaryColor: .white)
//                                .opacity(0.5)
//                                .padding()
//                        }
//                    }
//                    Spacer().frame(width: 25) // Pousse le texte vers la droite
//                    VStack {
//                        PixelLetterView(text: "N I V   8", primaryColor: .brown)
//                    }
//                }
//                .padding(.top, 100)
//
//                VStack(spacing: 5) {
//                    CharacteristicRow(
//                        symbolText: "boot",
//                        characteristicName: "   E x p l o r a t i o n",
//                        value: formatNumber(Int(agility)),
//                        unit: " P A S",
//                        primaryColor: .yellow,
//                        destinationView: AgilityView()
//                    )
//                    .padding(.horizontal, 40)
//
//                    CharacteristicRow(
//                        symbolText: "heart",
//                        characteristicName: "   V i t a l i t e",
//                        value: formatNumber(Int(constitution)),
//                        unit: " K C A L",
//                        primaryColor: .green,
//                        destinationView: VitalityView()
//                    )
//                    .padding(.horizontal, 40)
//
//                    CharacteristicRow(
//                        symbolText: "hand",
//                        characteristicName: "   F o r c e",
//                        value: formatNumber(Int(force)),
//                        unit: " K C A L",
//                        primaryColor: .orange,
//                        destinationView: StrengthView()
//                    )
//                    .padding(.horizontal, 40)
//
//                    CharacteristicRow(
//                        symbolText: "book",
//                        characteristicName: "   M e d i t a t i o n",
//                        value: formatNumber(Int(intelligence)), // Affiche en minutes
//                        unit: " M I N",
//                        primaryColor: .blue,
//                        destinationView: IntelligenceView()
//                    )
//                    .padding(.horizontal, 40)
//
//                    CharacteristicRow(
//                        symbolText: "lightning",
//                        characteristicName: "   R e p o s",
//                        value: formatDuration(Int(energy)), // Affiche les minutes en heures et minutes
//                        unit: " M I N",
//                        primaryColor: .purple,
//                        destinationView: EnergyView()
//                    )
//                    .padding(.horizontal, 40)
//                }
//                .padding(.top, 50)
//            }
//            HStack {
//                Button(action: {
//                    dismiss() // Action pour revenir en arrière
//                }) {
//                    VStack {
//                        Spacer()
//                        PixelIconView(iconName: "arrow").opacity(0.5)
//                    }
//                }
//                Spacer()
//            }
//            .padding()
//        }
//        .navigationBarHidden(true) // Masquer complètement la barre de navigation par défaut
//        .onAppear(perform: requestHealthData)
//    }
//    
//    func formatNumber(_ number: Int) -> String {
//        return String(number).map { String($0) }.joined(separator: " ")
//    }
//
//    func formatDuration(_ totalMinutes: Int) -> String {
//        let hours = totalMinutes / 60
//        let minutes = totalMinutes % 60
//        return "\(hours)h \(minutes)m"
//    }
//
//    func requestHealthData() {
//        let typesToRead = Set([
//            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
//            HKObjectType.categoryType(forIdentifier: .mindfulSession)!,
//            HKObjectType.quantityType(forIdentifier: .stepCount)!,
//            HKObjectType.quantityType(forIdentifier: .basalEnergyBurned)!,
//            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
//        ])
//        
//        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { success, error in
//            if success {
//                fetchHealthData()
//            } else if let error = error {
//                print("Erreur lors de la demande d'autorisation : \(error.localizedDescription)")
//            }
//        }
//    }
//
//    func fetchHealthData() {
//        fetchActiveCalories()
//        fetchMindfulMinutes()
//        fetchStepCount()
//        fetchBasalCalories()
//        fetchSleepMinutes()
//    }
//
//    func fetchActiveCalories() {
//        let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
//        
//        let now = Date()
//        let startOfDay = Calendar.current.startOfDay(for: now)
//        
//        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
//        
//        let query = HKStatisticsQuery(quantityType: calorieType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
//            
//            if let error = error {
//                print("Erreur lors de la récupération des calories actives : \(error.localizedDescription)")
//                return
//            }
//            
//            if let result = result, let sum = result.sumQuantity() {
//                DispatchQueue.main.async {
//                    self.force = sum.doubleValue(for: .kilocalorie())
//                }
//            }
//        }
//        
//        healthStore.execute(query)
//    }
//
//    func fetchSleepMinutes() {
//        let sleepAnalysis = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!
//        
//        let now = Date()
//        let startOfDay = Calendar.current.startOfDay(for: now)
//
//        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
//
//        let query = HKSampleQuery(sampleType: sleepAnalysis, predicate: predicate, limit: 0, sortDescriptors: nil) { _, samples, error in
//            
//            if let error = error {
//                print("Erreur lors de la récupération des données sur le sommeil : \(error.localizedDescription)")
//                return
//            }
//
//            guard let samples = samples as? [HKCategorySample] else { return }
//
//            DispatchQueue.main.async {
//                self.energy = samples.reduce(0.0) { sum, sample in sum + sample.endDate.timeIntervalSince(sample.startDate) / 60.0 }
//            }
//        }
//        
//        healthStore.execute(query)
//    }
//
//    func fetchMindfulMinutes() {
//        let mindfulType = HKCategoryType.categoryType(forIdentifier: .mindfulSession)!
//        
//        let now = Date()
//        let startOfDay = Calendar.current.startOfDay(for: now)
//
//        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
//
//        let query = HKSampleQuery(sampleType: mindfulType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, samples, error in
//            
//            if let error = error {
//                print("Erreur lors de la récupération des minutes de respiration : \(error.localizedDescription)")
//                return
//            }
//
//            guard let samples = samples as? [HKCategorySample] else {
//                print("Aucun échantillon trouvé.")
//                return
//            }
//
//            DispatchQueue.main.async {
//                self.intelligence = samples.reduce(0.0) { sum, sample in sum + sample.endDate.timeIntervalSince(sample.startDate) / 60.0 }
//            }
//        }
//
//        healthStore.execute(query)
//    }
//
//    func fetchStepCount() {
//        let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
//        
//        let now = Date()
//        let startOfDay = Calendar.current.startOfDay(for: now)
//
//        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
//
//        let query = HKStatisticsQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
//            
//            if let error = error {
//                print("Erreur lors de la récupération du nombre de pas : \(error.localizedDescription)")
//                return
//            }
//
//            if let result = result, let sum = result.sumQuantity() {
//                DispatchQueue.main.async {
//                    self.agility = sum.doubleValue(for: .count())
//                }
//            }
//        }
//
//        healthStore.execute(query)
//    }
//
//    func fetchBasalCalories() {
//        let basalCalorieType = HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!
//        
//        let now = Date()
//        let startOfDay = Calendar.current.startOfDay(for: now)
//
//        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
//
//        let query = HKStatisticsQuery(quantityType: basalCalorieType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
//            
//            if let error = error {
//                print("Erreur lors de la récupération des calories basales : \(error.localizedDescription)")
//                return
//            }
//
//            if let result = result, let sum = result.sumQuantity() {
//                DispatchQueue.main.async {
//                    self.constitution = sum.doubleValue(for: .kilocalorie())
//                }
//            }
//        }
//
//        healthStore.execute(query)
//    }
//}
//
//
//
//#Preview {
//    ProfileView().background(.black)
//        .preferredColorScheme(.dark)
//}
//
//
//struct CharacteristicRow<Destination>: View where Destination : View {
//    var symbolText : String
//    var characteristicName : String
//    var value : String
//    var unit : String
//    
//    // Ajout de paramètres pour les couleurs personnalisées
//    var primaryColor : Color = .white
//    
//    // Vue de destination pour la navigation
//    var destinationView : Destination?
//    
//    var body : some View{
//       HStack{
//           if let destination = destinationView {
//               NavigationLink(destination : destination) {
//                   rowContent
//               }
//               .buttonStyle(PlainButtonStyle())
//           } else {
//               rowContent
//           }
//       }
//       .padding()
//   }
//
//   // Contenu de la ligne (icône + texte + valeur)
//   private var rowContent : some View {
//       HStack{
//           PixelIconView(iconName : symbolText , primaryColor : primaryColor )
//               .frame(width : 40 , height :40 )
//           PixelLetterView(text: characteristicName.uppercased()).opacity(0.5)
//           Spacer()
//           PixelLetterView(text : value , primaryColor : primaryColor)
//           PixelLetterView(text: unit, primaryColor: primaryColor).opacity(0.5)
//       }
//   }
//}
//
//struct User {
//   var name: String
//   var intelligence: Int
//   var energy: Int
//   var force: Int
//   var constitution: Int
//   var agility: Int
//}
