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
                .animation(.easeInOut, value: settings.firstLaunch)
                .appReviewPrompt()
        }
        .onChange(of: settings.accentColor) { _ in
            WidgetCenter.shared.reloadAllTimelines()
        }
        .onChange(of: scenePhase) { _ in
            quranPlayer.saveLastListenedSurah()
        }
    }

    @ViewBuilder
    private var rootContent: some View {
        if isLaunching {
            LaunchScreen(isLaunching: $isLaunching)
        } else if settings.firstLaunch {
            SplashScreen()
        } else {
            MainTabView()
        }
    }
}

private struct MainTabView: View {
    @EnvironmentObject private var quranPlayer: QuranPlayer

    var body: some View {
        TabView {
            QuranView()
                .tabItem {
                    Image(systemName: "character.book.closed.ar")
                    Text("Quran")
                }

            IslamView()
                .withNowPlayingInset()
                .tabItem {
                    Image(systemName: "moon.stars")
                    Text("Tools")
                }

            SettingsView()
                .withNowPlayingInset()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
    }
}

private struct NowPlayingInsetModifier: ViewModifier {
    @EnvironmentObject private var quranPlayer: QuranPlayer

    func body(content: Content) -> some View {
        content.safeAreaInset(edge: .bottom) {
            VStack(spacing: SafeAreaInsetVStackSpacing.standard) {
                if quranPlayer.isPlaying || quranPlayer.isPaused {
                    NowPlayingView()
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 8)
            .animation(.easeInOut, value: quranPlayer.isPlaying)
        }
    }
}

private extension View {
    func withNowPlayingInset() -> some View {
        modifier(NowPlayingInsetModifier())
    }
}
