import SwiftUI
import WatchConnectivity

@main
struct AlQuranApp: App {
    @StateObject private var settings = Settings.shared
    @StateObject private var quranData = QuranData.shared
    @StateObject private var quranPlayer = QuranPlayer.shared
    @StateObject private var namesData = NamesViewModel.shared
    
    @State private var isLaunching = true
    
    init() {
        _ = WatchConnectivityManager.shared
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isLaunching {
                    LaunchScreen(isLaunching: $isLaunching)
                } else {
                    TabView {
                        SurahsView()
                        
                        OtherView()
                        
                        SettingsView()
                    }
                }
            }
            .environmentObject(quranData)
            .environmentObject(quranPlayer)
            .environmentObject(namesData)
            .environmentObject(settings)
            .accentColor(settings.accentColor.color)
            .tint(settings.accentColor.color)
            .preferredColorScheme(settings.colorScheme)
            .transition(.opacity)
        }
        .onChange(of: settings.lastReadSurah) { newValue in
            sendMessageToPhone()
        }
        .onChange(of: settings.lastReadAyah) { newValue in
            sendMessageToPhone()
        }
        .onChange(of: settings.favoriteSurahs) { newValue in
            sendMessageToPhone()
        }
        .onChange(of: settings.bookmarkedAyahs) { newValue in
            sendMessageToPhone()
        }
        .onChange(of: settings.favoriteLetters) { newValue in
            sendMessageToPhone()
        }
    }
    
    func sendMessageToPhone() {
        let settingsData = settings.dictionaryRepresentation()
        let message = ["settings": settingsData]

        if WCSession.default.isReachable {
            print("Phone is reachable. Sending message to phone: \(message)")
            WCSession.default.sendMessage(message, replyHandler: nil) { error in
                print("Error sending message to phone: \(error.localizedDescription)")
            }
        } else {
            print("Phone is not reachable. Transferring user info to phone: \(message)")
            WCSession.default.transferUserInfo(message)
        }
    }
}
