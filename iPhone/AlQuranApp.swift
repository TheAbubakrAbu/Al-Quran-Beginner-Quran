import SwiftUI
import WatchConnectivity

@main
struct BeginnerQuranApp: App {
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
                } else if settings.firstLaunch {
                    SplashScreen()
                } else {
                    SurahsView()
                }
            }
            .environmentObject(quranData)
            .environmentObject(quranPlayer)
            .environmentObject(namesData)
            .environmentObject(settings)
            .accentColor(settings.accentColor.color)
            .preferredColorScheme(settings.colorScheme)
            .transition(.opacity)
        }
        .onChange(of: settings.lastReadSurah) { _ in
            sendMessageToWatch()
        }
        .onChange(of: settings.lastReadAyah) { _ in
            sendMessageToWatch()
        }
        .onChange(of: settings.favoriteSurahs) { _ in
            sendMessageToWatch()
        }
        .onChange(of: settings.bookmarkedAyahs) { _ in
            sendMessageToWatch()
        }
        .onChange(of: settings.favoriteLetters) { _ in
            sendMessageToWatch()
        }
        .onChange(of: settings.accentColor) { _ in
            sendMessageToWatch()
        }
    }
    
    private func sendMessageToWatch() {
        guard WCSession.default.isPaired else {
            print("No Apple Watch is paired")
            return
        }
        
        let settingsData = settings.dictionaryRepresentation()
        let message = ["settings": settingsData]

        if WCSession.default.isReachable {
            print("Watch is reachable. Sending message to watch: \(message)")

            WCSession.default.sendMessage(message, replyHandler: nil) { error in
                print("Error sending message to watch: \(error.localizedDescription)")
            }
        } else {
            print("Watch is not reachable. Transferring user info to watch: \(message)")
            WCSession.default.transferUserInfo(message)
        }
    }
}

struct DismissKeyboardOnScrollModifier: ViewModifier {
    func body(content: Content) -> some View {
        Group {
            if #available(iOS 16.0, *) {
                content
                    .scrollDismissesKeyboard(.immediately)
            } else {
                content
                    .gesture(
                        DragGesture().onChanged { _ in
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                    )
            }
        }
    }
}

extension View {
    func applyConditionalListStyle(defaultView: Bool) -> some View {
        self.modifier(ConditionalListStyle(defaultView: defaultView))
    }
    
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func dismissKeyboardOnScroll() -> some View {
        self.modifier(DismissKeyboardOnScrollModifier())
    }
}

struct ConditionalListStyle: ViewModifier {
    @EnvironmentObject var settings: Settings
    
    @Environment(\.colorScheme) var systemColorScheme
    @Environment(\.customColorScheme) var customColorScheme
    
    var defaultView: Bool
    
    var currentColorScheme: ColorScheme {
        if let colorScheme = settings.colorScheme {
            return colorScheme
        } else {
            return systemColorScheme
        }
    }

    func body(content: Content) -> some View {
        Group {
            if defaultView {
                content
                    .accentColor(settings.accentColor.color)
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                content
                    .listStyle(PlainListStyle())
                    .accentColor(settings.accentColor.color)
                    .background(currentColorScheme == .dark ? Color.black : Color.white)
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    
    var onSearchButtonClicked: (() -> Void)?

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }

        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = true
        }

        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
            searchBar.text = ""
            searchBar.resignFirstResponder()

            text = ""
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search"
        searchBar.autocorrectionType = .no
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        DispatchQueue.main.async {
            self.text = searchBar.text ?? ""
        }
    }
}
