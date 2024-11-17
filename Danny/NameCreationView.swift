import SwiftUI

struct NameCreationView: View {
    @State private var userName: String = ""  // Variable pour stocker le nom saisi
    @Environment(\.presentationMode) var presentationMode  // Pour revenir à la vue précédente
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Choisissez un nom pour votre avatar")
                .font(.headline)
                .padding()
            
            // Champ texte pour entrer le nom
            TextField("Entrez votre nom", text: $userName)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
            
            // Bouton de validation
            Button(action: {
                saveUserName(name: userName)  // Sauvegarder le nom
                presentationMode.wrappedValue.dismiss()  // Fermer la vue après validation
            }) {
                Text("Valider")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
    
    // Fonction pour sauvegarder le nom dans UserDefaults
    func saveUserName(name: String) {
        UserDefaults.standard.set(name, forKey: "userName")
    }
}

#Preview {
    NameCreationView()
}
