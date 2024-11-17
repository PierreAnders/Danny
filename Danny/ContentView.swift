import SwiftUI
import HealthKit

struct ContentView: View {
    let healthStore = HKHealthStore()

    var body: some View {
        NavigationView { // Ajout du NavigationView pour gérer la navigation
            VStack {
                Spacer().frame(height: 40)
//
                // PixelArtView devient cliquable grâce à NavigationLink
                NavigationLink(destination: ProfileView()) {
                    PixelArtView()
                        .frame(width: 200, height: 200)
                        .padding(.bottom, 60)
                }
                .buttonStyle(PlainButtonStyle())
                
//                Spacer().frame(height: 5)

//                PixelLetterView(text: "H E L L O   W O R L D")
//                    .frame(width: 100, height: 30)
                
                PixelLetterView(text: "H E L L O   W O R L D")
//                Text("hello world !")
//                    .font(.custom("IBMPlexMono-Regular", size: 16))
//                    .background(Color.black) // Fond noir pour un effet terminal rétro
            }
            .onAppear(perform: requestHealthKitAuthorization) // Demande d'autorisation HealthKit à l'apparition de la vue.
        }
    }

    func requestHealthKitAuthorization() {
        // Types de données à lire depuis HealthKit.
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier:.stepCount)!,
            HKObjectType.quantityType(forIdentifier:.heartRate)!,
            HKObjectType.quantityType(forIdentifier:.activeEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier:.heartRateVariabilitySDNN)!,
            HKObjectType.quantityType(forIdentifier:.vo2Max)!,
            HKObjectType.categoryType(forIdentifier:.mindfulSession)!,
            HKObjectType.categoryType(forIdentifier:.sleepAnalysis)!,
            HKObjectType.quantityType(forIdentifier:.respiratoryRate)!,
            HKObjectType.quantityType(forIdentifier:.basalEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier:.distanceWalkingRunning)!, // Distance parcourue
            HKObjectType.quantityType(forIdentifier:.flightsClimbed)!, // Escaliers montés
            HKObjectType.quantityType(forIdentifier:.walkingSpeed)!, // Vitesse de marche
            HKObjectType.quantityType(forIdentifier:.walkingAsymmetryPercentage)! // Asymétrie de la marche
        ]

        // Demande d'autorisation pour lire les données HealthKit.
        healthStore.requestAuthorization(toShare:nil, read :healthKitTypesToRead) { success,error in
            if success{
               print("Autorisation réussie")
           } else if let error=error{
               print("Erreur lors de la demande d'autorisation : \(error.localizedDescription)")
           }
       }
   }
}

#Preview{
   ContentView()
}
