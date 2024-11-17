import SwiftUI
import HealthKit

struct VitalityView: View {
    @State private var basalCalories: Double = 0 // Variable pour stocker les calories basales
    @State private var respiratoryRate: Double = 0 // Variable pour stocker la fréquence respiratoire
    @State private var heartRate: Double = 0 // Variable pour stocker la fréquence cardiaque
    @State private var heartRateVariability: Double = 0 // Variable pour stocker la variabilité de la fréquence cardiaque
    let healthStore = HKHealthStore()
    
    var body: some View {
        ScrollView { // Ajout du ScrollView pour permettre le défilement
            VStack(spacing: 16) {
                PixelIconView(iconName: "heart", primaryColor: .green)
                    .padding(.bottom, 15)
                    .padding(.top, 80)
                
                // TODO SUITE
//                PixelLetterView(text: "V I T A L I T E, primaryColor: .white)
//                    .padding(.bottom, 30)
//                
//                                HStack {
                PixelLetterView(text: "C A L O R I E S   A U   R E P O S", primaryColor: .white, backgroundColor: .black)
                    .padding()
                
                PixelLetterView(text: "\(formatNumber(Int(basalCalories)))   K C A L", primaryColor: .white, backgroundColor: .black)
                    .padding()
                
                PixelLetterView(text: "F R É Q U E N C E   R E S P I R A T O I R E", primaryColor: .white, backgroundColor: .black)
                    .padding()
                
                PixelLetterView(text: "\(formatNumber(Int(respiratoryRate)))   R P M", primaryColor: .white, backgroundColor: .black)
                    .padding()
                
                PixelLetterView(text: "F R É Q U E N C E   C A R D I A Q U E", primaryColor: .white, backgroundColor: .black)
                    .padding()
                
                PixelLetterView(text: "\(formatNumber(Int(heartRate)))   B P M", primaryColor: .white, backgroundColor: .black) // Affichage de la fréquence cardiaque
                    .padding()
                
                PixelLetterView(text: "V A R I A B I L I T É   F C", primaryColor: .white, backgroundColor: .black)
                    .padding()
                
                PixelLetterView(text: "\(formatNumber(Int(heartRateVariability)))   M S", primaryColor: .white, backgroundColor: .black) // Affichage de la variabilité de la fréquence cardiaque
                    .padding()

                Spacer()
            }
        }
        .onAppear(perform: startHealthQueries)
    }
    
    func formatNumber(_ number: Int) -> String {
        return String(number).map { String($0) }.joined(separator: " ")
    }
    
    func startHealthQueries() {
        let basalCalorieType = HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!
        let respiratoryRateType = HKQuantityType.quantityType(forIdentifier: .respiratoryRate)!
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let heartRateVariabilityType = HKQuantityType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!
        
        let typesToRead = Set([basalCalorieType, respiratoryRateType, heartRateType, heartRateVariabilityType])
        
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { success, error in
            if success {
                fetchBasalCalories()
                fetchRespiratoryRate()
                fetchHeartRate()
                fetchHeartRateVariability()
            } else if let error = error {
                print("Erreur lors de la demande d'autorisation : \(error.localizedDescription)")
            }
        }
    }

    func fetchBasalCalories() {
        let basalCalorieType = HKQuantityType.quantityType(forIdentifier:.basalEnergyBurned)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart:startOfDay,end :now ,options:.strictStartDate)
        
        let basalQuery=HKStatisticsQuery(quantityType :basalCalorieType ,quantitySamplePredicate :predicate ,options :.cumulativeSum){_,result,error in
            
            if let error=error{
                print("Erreur lors de la récupération des calories basales : \(error.localizedDescription)")
                return
            }
            
            var basalCaloriesValue=0.0
            if let result=result ,let sum=result.sumQuantity(){
                basalCaloriesValue=sum.doubleValue(for :HKUnit.kilocalorie())
            }
            
            DispatchQueue.main.async{
                self.basalCalories=basalCaloriesValue
            }
        }
        
        healthStore.execute(basalQuery)
    }

    func fetchRespiratoryRate() {
        let respiratoryRateType=HKQuantityType.quantityType(forIdentifier :.respiratoryRate)!
        
        let now=Date()
        let startOfDay=Calendar.current.startOfDay(for :now)
        
        let predicate=HKQuery.predicateForSamples(withStart:startOfDay,end :now ,options :.strictStartDate)
        
        let respiratoryQuery=HKStatisticsQuery(quantityType :respiratoryRateType ,quantitySamplePredicate :predicate ,options :.discreteAverage){_,result,error in
            
            if let error=error{
                print("Erreur lors de la récupération de la fréquence respiratoire : \(error.localizedDescription)")
                return
            }
            
            var respiratoryRateValue=0.0
            if let result=result ,let avg=result.averageQuantity(){
                respiratoryRateValue=avg.doubleValue(for :HKUnit(from :"count/min"))
            }
            
            DispatchQueue.main.async{
                self.respiratoryRate=respiratoryRateValue
            }
        }
        
        healthStore.execute(respiratoryQuery)
    }

    func fetchHeartRate() {
        let heartRateType=HKQuantityType.quantityType(forIdentifier :.heartRate)!
        
        let now=Date()
        let startOfDay=Calendar.current.startOfDay(for :now)
        
        let predicate=HKQuery.predicateForSamples(withStart:startOfDay,end :now ,options :.strictStartDate)
        
        let heartQuery=HKStatisticsQuery(quantityType :heartRateType ,quantitySamplePredicate :predicate ,options :.discreteAverage){_,result,error in
            
           if let error=error{
               print("Erreur lors de la récupération des données du cœur : \(error.localizedDescription)")
               return
           }
           
           var heartRateValue=0.0
           if let result=result ,let avg=result.averageQuantity(){
               heartRateValue=avg.doubleValue(for :HKUnit(from :"count/min"))
           }

           DispatchQueue.main.async{
               self.heartRate=heartRateValue
           }
       }

       healthStore.execute(heartQuery)
   }

   func fetchHeartRateVariability() {
       let heartVariabilityType=HKQuantityType.quantityType(forIdentifier :.heartRateVariabilitySDNN)!

       let now=Date()
       let startOfDay=Calendar.current.startOfDay(for :now)

       let predicate=HKQuery.predicateForSamples(withStart:startOfDay,end :now ,options :.strictStartDate)

       let variabilityQuery=HKStatisticsQuery(quantityType :heartVariabilityType ,quantitySamplePredicate :predicate ,options :.discreteAverage){_,result,error in

           if let error=error{
               print("Erreur lors de la récupération des données de variabilité du cœur : \(error.localizedDescription)")
               return
           }

           var variabilityValue=0.0
           if let result=result ,let avg=result.averageQuantity(){
               variabilityValue=avg.doubleValue(for :HKUnit.secondUnit(with :.milli))
           }

           DispatchQueue.main.async{
               self.heartRateVariability=variabilityValue
           }
       }

       healthStore.execute(variabilityQuery)
   }
}

#Preview{
   VitalityView()
}
