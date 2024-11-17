import SwiftUI
import HealthKit

struct AgilityView: View {
    @State private var stepCount: Double = 0
    @State private var distance: Double = 0
    @State private var flightsClimbed: Double = 0
    @State private var walkingSpeed: Double = 0
    @State private var walkingAsymmetry: Double = 0
    let healthStore = HKHealthStore()

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
                VStack(spacing: 16) {
                    // Icone en haut
                    PixelIconView(iconName: "boot", primaryColor: .yellow)
                        .padding(.bottom, 15)
                        .padding(.top, 80)
                    
                    // Titre
                    PixelLetterView(text: "E X P L O R A T I O N", primaryColor: .white)
                        .padding(.bottom, 30)

                    // Nombre de pas
                    HStack {
                        PixelLetterView(
                            text: "N O M B R E   D E   P A S",
                            primaryColor: .white,
                            backgroundColor: .black
                        ).opacity(0.5)
                        Spacer()
                        PixelLetterView(
                            text: " \(formatNumber(Int(stepCount)))",
                            primaryColor: .yellow,
                            backgroundColor: .black
                        )
                        PixelLetterView(
                            text: "P A S ",
                            primaryColor: .yellow,
                            backgroundColor: .black
                        ).opacity(0.5)
                    }
                    .padding().padding(.horizontal, 40)

                    // Distance parcourue
                    HStack {
                        PixelLetterView(
                            text: "D I S T A N C E",
                            primaryColor: .white,
                            backgroundColor: .black
                        ).opacity(0.5)
                        Spacer()
                        PixelLetterView(
                            text: " \(String(format: "%.2f", distance))",
                            primaryColor: .yellow,
                            backgroundColor: .black
                        )
                        PixelLetterView(
                            text: "K M",
                            primaryColor: .yellow,
                            backgroundColor: .black
                        ).opacity(0.5)
                    }
                    .padding().padding(.horizontal, 40)

                    // Escaliers montés
                    HStack {
                        PixelLetterView(
                            text: "E S C A L I E R S",
                            primaryColor: .white,
                            backgroundColor: .black
                        ).opacity(0.5)
                        Spacer()
                        PixelLetterView(
                            text: " \(formatNumber(Int(flightsClimbed)))",
                            primaryColor: .yellow,
                            backgroundColor: .black
                        )
                        PixelLetterView(
                            text: "E T A G E S",
                            primaryColor: .yellow,
                            backgroundColor: .black
                        ).opacity(0.5)
                    }
                    .padding().padding(.horizontal, 40)

                    // Vitesse de marche
                    HStack {
                        PixelLetterView(
                            text: "V I T E S S E",
                            primaryColor: .white,
                            backgroundColor: .black
                        ).opacity(0.5)
                        Spacer()
                        PixelLetterView(
                            text: " \(String(format: "%.2f", walkingSpeed))",
                            primaryColor: .yellow,
                            backgroundColor: .black
                        )
                        PixelLetterView(
                            text: "M/S",
                            primaryColor: .yellow,
                            backgroundColor: .black
                        ).opacity(0.5)
                    }
                    .padding().padding(.horizontal, 40)

                    // Asymétrie de la marche
                    HStack {
                        PixelLetterView(
                            text: "A S Y M E T R I E",
                            primaryColor: .white,
                            backgroundColor: .black
                        ).opacity(0.5)
                        Spacer()
                        PixelLetterView(
                            text: " \(String(format: "%.2f", walkingAsymmetry))",
                            primaryColor: .yellow,
                            backgroundColor: .black
                        )
                        PixelLetterView(
                            text: "%",
                            primaryColor: .yellow,
                            backgroundColor: .black
                        ).opacity(0.5)
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
        .onAppear(perform: fetchHealthData)
    }


    func formatNumber(_ number:Int)->String{
        return String(number).map{String($0)}.joined(separator:" ")
    }

    func fetchHealthData() {
        fetchStepCount()
        fetchDistance()
        fetchFlightsClimbed()
        fetchWalkingSpeed()
        fetchWalkingAsymmetry()
    }

    func fetchStepCount() {
        let stepType = HKQuantityType.quantityType(forIdentifier:.stepCount)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for :now)
        
        let predicate=HKQuery.predicateForSamples(withStart:startOfDay,end :now ,options :.strictStartDate)
        
        let query=HKStatisticsQuery(quantityType :stepType ,quantitySamplePredicate :predicate ,options :.cumulativeSum){ _,result,error in
            
            if let error=error{
                print("Erreur lors de la récupération du nombre de pas : \(error.localizedDescription)")
                return
            }
            
            if let result=result ,let sum=result.sumQuantity(){
                DispatchQueue.main.async{
                    self.stepCount=sum.doubleValue(for :.count())
                    print("Nombre de pas récupéré : \(self.stepCount)") // Vérification des données
                }
            }
        }
        
        healthStore.execute(query)
    }

    func fetchDistance() {
        let distanceType = HKQuantityType.quantityType(forIdentifier:.distanceWalkingRunning)!
        
        let now=Date()
        let startOfDay=Calendar.current.startOfDay(for :now)
        
        let predicate=HKQuery.predicateForSamples(withStart:startOfDay,end :now ,options :.strictStartDate)
        
        let query=HKStatisticsQuery(quantityType :distanceType ,quantitySamplePredicate :predicate ,options :.cumulativeSum){ _,result,error in
            
            if let error=error{
                print("Erreur lors de la récupération de la distance : \(error.localizedDescription)")
                return
            }
            
            if let result=result ,let sum=result.sumQuantity(){
                DispatchQueue.main.async{
                    self.distance=sum.doubleValue(for :.meterUnit(with:.kilo))
                    print("Distance récupérée : \(self.distance)") // Vérification des données
                }
            }
        }
        
        healthStore.execute(query)
    }

    func fetchFlightsClimbed() {
        let flightsClimbedType = HKQuantityType.quantityType(forIdentifier:.flightsClimbed)!
        
        let now=Date()
        let startOfDay=Calendar.current.startOfDay(for :now)
        
        let predicate=HKQuery.predicateForSamples(withStart:startOfDay,end :now ,options :.strictStartDate)
        
        let query=HKStatisticsQuery(quantityType :flightsClimbedType ,quantitySamplePredicate :predicate ,options :.cumulativeSum){ _,result,error in
            
            if let error=error{
                print("Erreur lors de la récupération des escaliers montés : \(error.localizedDescription)")
                return
            }
            
            if let result=result ,let sum=result.sumQuantity(){
                DispatchQueue.main.async{
                    self.flightsClimbed=sum.doubleValue(for :.count())
                    print("Escaliers montés récupérés : \(self.flightsClimbed)") // Vérification des données
                }
            }
        }
        
        healthStore.execute(query)
    }

    func fetchWalkingSpeed() {
        let walkingSpeedType = HKQuantityType.quantityType(forIdentifier:.walkingSpeed)!
        
        let now=Date()
        let startOfDay=Calendar.current.startOfDay(for :now)
        
        let predicate=HKQuery.predicateForSamples(withStart:startOfDay,end :now ,options :.strictStartDate)
        
        let query=HKStatisticsQuery(quantityType :walkingSpeedType ,quantitySamplePredicate :predicate ,options :.discreteAverage){ _,result,error in
            
            if let error=error{
                print("Erreur lors de la récupération de la vitesse de marche : \(error.localizedDescription)")
                return
            }
            
            if let result=result ,let avg=result.averageQuantity(){
                DispatchQueue.main.async{
                    self.walkingSpeed=avg.doubleValue(for :.meter().unitDivided(by:.second()))
                    print("Vitesse de marche récupérée : \(self.walkingSpeed)") // Vérification des données
                }
            }
        }
        
        healthStore.execute(query)
    }

    func fetchWalkingAsymmetry() {
        let asymmetryType = HKQuantityType.quantityType(forIdentifier:.walkingAsymmetryPercentage)!
        
        let now=Date()
          let startOfDay=Calendar.current.startOfDay(for :now)

          let predicate=HKQuery.predicateForSamples(withStart:startOfDay,end :now ,options :.strictStartDate)

          let query = HKStatisticsQuery(quantityType :asymmetryType, quantitySamplePredicate :predicate, options :.discreteAverage) { _, result, error in

             if    let error = error {
                 print("Erreur lors de la récupération de l'asymétrie de marche : \(error.localizedDescription)")
                 return
             }

             if    let result = result,
                 let avg = result.averageQuantity() {
                 DispatchQueue.main.async {
                     self.walkingAsymmetry = avg.doubleValue(for :.percent())
                     print("Asymétrie récupérée : \(self.walkingAsymmetry)") // Vérification des données
                 }
             }
          }

          healthStore.execute(query)
    }
}

#Preview {
    AgilityView().preferredColorScheme(.dark)
}
