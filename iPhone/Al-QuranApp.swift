import SwiftUI
import WidgetKit

@main
struct AlIslamApp: App {
    @StateObject private var settings = Settings.shared
    @StateObject private var quranData = QuranData.shared
    @StateObject private var quranPlayer = QuranPlayer.shared
    @StateObject private var namesData = NamesViewModel.shared

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase

    @State private var isLaunching = true

    init() {
        // Activate WatchConnectivity so settings sync (and watch app-installed detection) work both ways.
        _ = WatchConnectivityManager.shared
    }

    private enum RootStage: Equatable {
        case launch
        case splash
        case main
    }

    private var rootStage: RootStage {
        if isLaunching {
            return .launch
        }
        return settings.firstLaunch ? .splash : .main
    }

    private var rootTransitionAnimation: Animation {
        .easeInOut(duration: 0.42)
    }

    var body: some Scene {
        WindowGroup {
            rootContent
                .environmentObject(settings)
                .environmentObject(quranData)
                .environmentObject(quranPlayer)
                .environmentObject(namesData)
                .accentColor(settings.accentColor.color)
                .tint(settings.accentColor.color)
                .preferredColorScheme(settings.colorScheme)
                .appReviewPrompt()
                //.statusBarHidden()
        }
        .onChange(of: settings.accentColor) { _ in
            WidgetCenter.shared.reloadAllTimelines()
        }
        .onChange(of: scenePhase) { phase in
            quranPlayer.saveLastListenedSurah()
            quranPlayer.saveLastListenedAyah()
            settings.refreshQuranWidgets()
            if phase != .active {
                // Send any just-made setting change before the app is suspended, so it can't be lost (and
                // can't be reverted by a stale synced value on the next launch).
                WatchConnectivityManager.shared.flushPendingSync()
            }
        }
    }

    @ViewBuilder
    private var rootContent: some View {
        ZStack {
            if rootStage == .launch {
                LaunchScreen(isLaunching: $isLaunching)
                    .zIndex(3)
                    .transition(.opacity)
            }

            if rootStage == .splash {
                SplashScreen()
                    .zIndex(2)
                    .transition(.opacity)
            }

            if rootStage == .main {
                MainTabView()
                    .zIndex(1)
                    .transition(.opacity)
            }
        }
        .animation(rootTransitionAnimation, value: rootStage)
    }
}

private struct MainTabView: View {
    @EnvironmentObject private var quranPlayer: QuranPlayer

    private enum AppTab: Hashable { case quran, islam, settings }
    @State private var selectedTab: AppTab = .quran

    var body: some View {
        tabs
    }

    @ViewBuilder
    private var tabs: some View {
        TabView(selection: $selectedTab) {
            QuranView()
                .tabItem {
                    Image(systemName: "character.book.closed.ar")
                    Text("Quran")
                }
                .tag(AppTab.quran)

            IslamView()
                .tabItem {
                    Image(systemName: "moon.stars")
                    Text("Islam")
                }
                .tag(AppTab.islam)

            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .tag(AppTab.settings)
        }
    }
}
