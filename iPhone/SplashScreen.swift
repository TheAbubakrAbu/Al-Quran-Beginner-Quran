import SwiftUI

struct SplashScreen: View {
    @EnvironmentObject var settings: Settings
            
    var body: some View {
        NavigationView {
            VStack {
                Text("Al-Quran | Beginner Quran is privacy-focused, ensuring that all data remains on your device. Enjoy an ad-free, subscription-free, and cost-free experience. This app is an extension of Al-Islam, which offers all the features of Al-Quran plus additional functionalities, including prayer times, Qibla direction, and widgets.")
                    .font(.title3)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .minimumScaleFactor(0.5)
                    .padding()
                
                Spacer()
                
                Image("Al-Islam")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        settings.hapticFeedback()
                        
                        withAnimation {
                            settings.firstLaunch = false
                        }
                        
                        if let url = URL(string: "https://apps.apple.com/us/app/al-islam-islamic-pillars/id6449729655?platform=iphone") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text("Download App")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                            .background(settings.accentColor.color)
                            .foregroundColor(.primary)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        settings.hapticFeedback()
                        
                        withAnimation {
                            settings.firstLaunch = false
                        }
                    }) {
                        Text("Skip Download")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                            .background(.red)
                            .foregroundColor(.primary)
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
            }
            .navigationTitle("Assalamu Alaikum")
        }
        .navigationViewStyle(.stack)
    }
}
