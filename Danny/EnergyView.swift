import SwiftUI
import HealthKit

struct EnergyView: View {
    @State private var sleepMinutes: Double = 0
    @State private var coreSleepMinutes: Double = 0
    @State private var deepSleepMinutes: Double = 0
    @State private var remSleepMinutes: Double = 0
    @State private var isAuthorized: Bool = false
    let healthStore = HKHealthStore()
    
    var body: some View {
        ScrollView { // Ajout d'un ScrollView pour permettre le défilement
            VStack(spacing: 20) { // Espacement entre les éléments
                
                PixelIconView(iconName: "book", primaryColor: .blue)
                
                PixelLetterView(text: "D U R E E   S O M M E I L", primaryColor: .white, backgroundColor: .black)
                    .padding()
                
                // Affichage du temps total de sommeil
                PixelLetterView(text: "\(formatNumber(Int(sleepMinutes)))   M I N", primaryColor: .white, backgroundColor: .black)
                    .padding()
                
                // Affichage des détails par phase de sommeil
                VStack(alignment: .leading, spacing: 10) { // Espacement entre les lignes de texte
                    Text("Sommeil Léger (Core): \(Int(coreSleepMinutes)) min")
                        .foregroundColor(.white)
                    Text("Sommeil Profond (Deep): \(Int(deepSleepMinutes)) min")
                        .foregroundColor(.white)
                    Text("Sommeil Paradoxal (REM): \(Int(remSleepMinutes)) min")
                        .foregroundColor(.white)
                }
                .padding()
                
                Spacer() // Ajout d'un espace flexible en bas de la vue pour éviter que tout soit collé en haut
            }
            .padding() // Ajout d'un padding global pour éviter que le contenu touche les bords de l'écran
        }
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Fond noir sur toute la vue
        .onAppear {
            if isAuthorized {
                fetchSleepAnalysis()
            } else {
                requestHealthKitAuthorization()
            }
        }
    }
    
    func formatNumber(_ number: Int) -> String {
        return String(number).map { String($0) }.joined(separator: " ")
    }
    
    func requestHealthKitAuthorization() {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead) { success, error in
            DispatchQueue.main.async {
                if success {
                    self.isAuthorized = true
                    self.fetchSleepAnalysis()
                } else if let error = error {
                    print("Erreur lors de la demande d'autorisation : \(error.localizedDescription)")
                }
            }
        }
    }

    func fetchSleepAnalysis() {
        let sleepType = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 0, sortDescriptors: nil) { _, results, error in
            if let error = error {
                print("Erreur lors de la récupération des données : \(error.localizedDescription)")
                return
            }

            guard let results = results as? [HKCategorySample] else {
                print("Aucun résultat trouvé.")
                return
            }

            print("Nombre d'échantillons trouvés : \(results.count)")
            
            // Variables temporaires pour calculer les durées par phase
            var totalSleepTime = 0.0
            var coreSleepTime = 0.0
            var deepSleepTime = 0.0
            var remSleepTime = 0.0
            
            // Calcul du temps total et par phase de sommeil
            for sample in results {
                let sleepDuration = sample.endDate.timeIntervalSince(sample.startDate) / 60.0
                
                switch sample.value {
                case HKCategoryValueSleepAnalysis.asleepCore.rawValue:
                    coreSleepTime += sleepDuration
                case HKCategoryValueSleepAnalysis.asleepDeep.rawValue:
                    deepSleepTime += sleepDuration
                case HKCategoryValueSleepAnalysis.asleepREM.rawValue:
                    remSleepTime += sleepDuration
                case HKCategoryValueSleepAnalysis.asleepUnspecified.rawValue,
                     HKCategoryValueSleepAnalysis.asleep.rawValue:
                    totalSleepTime += sleepDuration
                    
                default:
                    break // Ignorer les autres types comme éveillé (awake)
                }
                
                totalSleepTime += sleepDuration // Ajouter toutes les phases au temps total de sommeil
            }

            // Mise à jour sur le thread principal
            DispatchQueue.main.async {
                self.sleepMinutes = totalSleepTime
                self.coreSleepMinutes = coreSleepTime
                self.deepSleepMinutes = deepSleepTime
                self.remSleepMinutes = remSleepTime
            }
        }

        healthStore.execute(query)
    }
}
