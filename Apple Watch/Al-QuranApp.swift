import SwiftUI
import WidgetKit

@main
struct AlQuranApp: App {
    @StateObject private var settings = Settings.shared
    @StateObject private var quranData = QuranData.shared
    @StateObject private var quranPlayer = QuranPlayer.shared
    @StateObject private var namesData = NamesViewModel.shared

    @Environment(\.scenePhase) private var scenePhase
    @State private var isLaunching = true

    init() {
        // Activate WatchConnectivity early so we can tell whether the iPhone app is installed
        // (used to decide if the watch should schedule prayer notifications itself).
        _ = WatchConnectivityManager.shared
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if isLaunching {
                    LaunchScreen(isLaunching: $isLaunching)
                } else {
                    TabView {
                        QuranView()
                        
                        IslamView()
                                                
                        SettingsView()
                    }
                }
            }
            .environmentObject(settings)
            .environmentObject(quranData)
            .environmentObject(quranPlayer)
            .environmentObject(namesData)
            .accentColor(settings.accentColor.color)
            .tint(settings.accentColor.color)
            .preferredColorScheme(settings.colorScheme)
            .transition(.opacity)
            .animation(.easeInOut, value: isLaunching)
        }
        .onChange(of: settings.accentColor) { _ in
            WidgetCenter.shared.reloadAllTimelines()
        }
        .onChange(of: scenePhase) { phase in
            if phase != .active {
                // Flush any just-made setting change before suspension so it reliably reaches the iPhone.
                WatchConnectivityManager.shared.flushPendingSync()
            }
        }
    }
}
