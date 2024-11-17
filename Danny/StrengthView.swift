import SwiftUI
import HealthKit

struct StrengthView: View {
    @State private var workouts: [HKWorkout] = []
    let healthStore = HKHealthStore()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Icône de la vue
                Image(systemName: "hand.raised.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.red)
                
                // Affichage des séances d'entraînement récupérées
                ForEach(workouts, id: \.uuid) { workout in
                    createWorkoutView(workout: workout)
                }

                Spacer()
            }
            .padding()
        }
        .onAppear(perform: startWorkoutQuery)
    }

    // Fonction pour créer une vue pour chaque séance d'entraînement
    func createWorkoutView(workout: HKWorkout) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            let activityType = workout.workoutActivityType.name // Nom de l'activité (ex : "Course à pied")
            let duration = workout.duration / 60 // Durée en minutes
            let calories = workout.totalEnergyBurned?.doubleValue(for: .kilocalorie()) ?? 0.0 // Calories brûlées
            let distance = workout.totalDistance?.doubleValue(for: .meterUnit(with: .kilo)) ?? 0.0 // Distance parcourue en km

            Text("Activité : \(activityType)")
                .font(.headline)
                .foregroundColor(.primary)

            Text("Durée : \(String(format: "%.2f", duration)) min")
                .font(.subheadline)
                .foregroundColor(.blue)

            Text("Calories : \(String(format: "%.2f", calories)) Kcal")
                .font(.subheadline)
                .foregroundColor(.orange)

            Text("Distance : \(String(format: "%.2f", distance)) km")
                .font(.subheadline)
                .foregroundColor(.green)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 5)
        .padding(.horizontal)
    }

    // Fonction pour démarrer la requête des séances d'entraînement
    func startWorkoutQuery() {
        requestAuthorization()
        fetchWorkouts()
    }

    func requestAuthorization() {
        let typesToRead = Set([
            HKObjectType.workoutType() // Autorisation pour lire les séances d'entraînement
        ])
        
        healthStore.requestAuthorization(toShare:nil, read :typesToRead) { success, error in
            if !success {
                print("Erreur lors de la demande d'autorisation : \(error?.localizedDescription ?? "Inconnue")")
            }
        }
    }

    func fetchWorkouts() {
        // Utilisation de `nil` comme prédicat pour récupérer toutes les séances d'entraînement
        let query = HKSampleQuery(sampleType: HKObjectType.workoutType(), predicate: nil, limit: 10, sortDescriptors:[NSSortDescriptor(key:"startDate",ascending:false)]) { _, samples, error in
            
            if let error = error {
                print("Erreur lors de la récupération des séances d'entraînement : \(error.localizedDescription)")
                return
            }
            
            guard let workouts = samples as? [HKWorkout] else { return }
            
            DispatchQueue.main.async {
                self.workouts = workouts // Mettre à jour la liste des séances récupérées
            }
        }
        
        healthStore.execute(query)
    }
}

#Preview {
    StrengthView()
}

// Extension pour obtenir le nom lisible du type d'activité physique
extension HKWorkoutActivityType {
    var name: String {
        switch self {
        case .running:
            return "Course à pied"
        case .walking:
            return "Marche"
        case .cycling:
            return "Cyclisme"
        case .swimming:
            return "Natation"
        case .yoga:
            return "Yoga"
        case .functionalStrengthTraining:
            return "Entraînement fonctionnel"
        default:
            return "Autre activité"
        }
    }
}
