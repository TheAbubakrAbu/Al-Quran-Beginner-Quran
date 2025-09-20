import SwiftUI
import StoreKit

@main
struct AlQuranApp: App {
    @StateObject private var settings = Settings.shared
    @StateObject private var quranData = QuranData.shared
    @StateObject private var quranPlayer = QuranPlayer.shared
    @StateObject private var namesData = NamesViewModel.shared
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isLaunching = true
    
    @AppStorage("timeSpent") private var timeSpent: Double = 0
    @AppStorage("shouldShowRateAlert") private var shouldShowRateAlert: Bool = true
    @State private var startTime: Date?

    var body: some Scene {
        WindowGroup {
            Group {
                if isLaunching {
                    LaunchScreen(isLaunching: $isLaunching)
                } else if settings.firstLaunch {
                    SplashScreen()
                } else {
                    VStack {
                        TabView {
                            QuranView()
                                .tabItem {
                                    Image(systemName: "character.book.closed.ar")
                                    Text("Quran")
                                }
                            
                            VStack {
                                OtherView()
                                
                                NowPlayingView(quranView: false)
                                    .padding(.bottom, 9)
                                    .animation(.easeInOut, value: quranPlayer.isPlaying)
                            }
                            .tabItem {
                                Image(systemName: "moon.stars")
                                Text("Tools")
                            }
                            
                            VStack {
                                SettingsView()
                                
                                NowPlayingView(quranView: false)
                                    .padding(.bottom, 9)
                                    .animation(.easeInOut, value: quranPlayer.isPlaying)
                            }
                            .tabItem {
                                Image(systemName: "gearshape")
                                Text("Settings")
                            }
                        }
                    }
                }
            }
            //.statusBarHidden(true)
            .environmentObject(quranData)
            .environmentObject(quranPlayer)
            .environmentObject(namesData)
            .environmentObject(settings)
            .accentColor(settings.accentColor.color)
            .tint(settings.accentColor.color)
            .preferredColorScheme(settings.colorScheme)
            .transition(.opacity)
            .animation(.easeInOut, value: isLaunching)
            .animation(.easeInOut, value: settings.firstLaunch)
            .onAppear {
                if shouldShowRateAlert {
                    startTime = Date()
                    
                    let remainingTime = max(180 - timeSpent, 0)
                    if remainingTime == 0 {
                        guard let windowScene = UIApplication.shared.connectedScenes
                            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else {
                            return
                        }
                        SKStoreReviewController.requestReview(in: windowScene)
                        shouldShowRateAlert = false
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + remainingTime) {
                            guard let windowScene = UIApplication.shared.connectedScenes
                                .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else {
                                return
                            }
                            SKStoreReviewController.requestReview(in: windowScene)
                            shouldShowRateAlert = false
                        }
                    }
                }
            }
            .onDisappear {
                if shouldShowRateAlert, let startTime = startTime {
                    timeSpent += Date().timeIntervalSince(startTime)
                }
            }
        }
        .onChange(of: scenePhase) { _ in
            quranPlayer.saveLastListenedSurah()
        }
    }
}
