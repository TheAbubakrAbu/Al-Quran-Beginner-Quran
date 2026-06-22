import SwiftUI
import WidgetKit

@main
struct AlQuranApp: App {
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
        }
        .onChange(of: settings.accentColor) { _ in
            WidgetCenter.shared.reloadAllTimelines()
        }
        .onChange(of: scenePhase) { phase in
            quranPlayer.saveLastListenedSurah()
            quranPlayer.saveLastListenedAyah()
            settings.refreshQuranWidgets()
            if phase == .active {
            } else {
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

    private enum AppTab: Hashable { case adhan, quran, islam, settings }
    @State private var selectedTab: AppTab = .adhan

    var body: some View {
        tabs
            // Single Now Playing bar for the whole app, applied once at the root so it persists across every
            // screen — including pushed subviews — instead of each tab adding it. Suppressed on the Quran tab,
            // which renders its own richer bar (scroll-to-surah, in-Quran navigation).
            .safeAreaInset(edge: .bottom) {
                if selectedTab != .quran,
                   quranPlayer.isPlaying || quranPlayer.isPaused {
                    VStack(spacing: SafeAreaInsetVStackSpacing.standard) {
                        NowPlayingView()
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 8)
                    .background(Color.white.opacity(0.00001))
                    .animation(.easeInOut, value: quranPlayer.isPlaying || quranPlayer.isPaused)
                }
            }
    }

    @ViewBuilder
    private var tabs: some View {
        if #available(iOS 18.0, *) {
            TabView(selection: $selectedTab) {
                Tab("Quran", systemImage: "character.book.closed.ar", value: AppTab.quran) {
                    QuranView()
                }

                Tab("Islam", systemImage: "moon.stars", value: AppTab.islam) {
                    IslamView()
                }

                Tab("Settings", systemImage: "gearshape", value: AppTab.settings) {
                    SettingsView()
                }
            }
        } else {
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
}

