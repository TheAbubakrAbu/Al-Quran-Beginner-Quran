import SwiftUI

struct OtherView: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("ISLAMIC RESOURCES")) {
                    NavigationLink(destination: ArabicView()) {
                        Label(
                            title: { Text("Arabic Alphabet") },
                            icon: { Image(systemName: "textformat.size.ar") }
                        )
                        .padding(.vertical, 4)
                    }
                    
                    NavigationLink(destination: AdhkarView()) {
                        Label(
                            title: { Text("Common Adhkar") },
                            icon: { Image(systemName: "book.closed") }
                        )
                        .padding(.vertical, 4)
                    }
                    
                    NavigationLink(destination: DuaView()) {
                        Label(
                            title: { Text("Common Duas") },
                            icon: { Image(systemName: "text.book.closed") }
                        )
                        .padding(.vertical, 4)
                    }
                    
                    NavigationLink(destination: TasbihView()) {
                        Label(
                            title: { Text("Tasbih Counter") },
                            icon: { Image(systemName: "circles.hexagonpath.fill") }
                        )
                        .padding(.vertical, 4)
                    }
                    
                    NavigationLink(destination: NamesView()) {
                        Label(
                            title: { Text("99 Names of Allah") },
                            icon: { Image(systemName: "signature") }
                        )
                        .padding(.vertical, 4)
                    }
                    
                    #if !os(watchOS)
                    NavigationLink(destination: DateView()) {
                        Label(
                            title: { Text("Hijri Calendar Converter") },
                            icon: { Image(systemName: "calendar") }
                        )
                        .padding(.vertical, 4)
                    }
                    #endif
                    
                    NavigationLink(destination: WallpaperView()) {
                        Label(
                            title: { Text("Islamic Wallpapers") },
                            icon: { Image(systemName: "photo.on.rectangle") }
                        )
                        .padding(.vertical, 4)
                    }
                }
                
                ProphetQuote()
                
                AlIslamAppsSection()
            }
            .applyConditionalListStyle(defaultView: settings.defaultView)
            .navigationTitle("Tools")
        }
    }
}

struct ProphetQuote: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        Section(header: Text("PROPHET MUHAMMAD ﷺ QUOTE")) {
            VStack(alignment: .center) {
                ZStack {
                    Circle()
                        .strokeBorder(settings.accentColor.color, lineWidth: 1)
                        .frame(width: 60, height: 60)

                    Text("ﷺ")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(settings.accentColor.color)
                        .padding()
                }
                .padding(4)
                
                Text("“All mankind is from Adam and Eve, an Arab has no superiority over a non-Arab nor a non-Arab has any superiority over an Arab; also a white has no superiority over a black, nor a black has any superiority over a white except by piety and good action.“")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(settings.accentColor.color)
                
                Text("Farewell Sermon\nJummuah, 9 Dhul-Hijjah 10 AH\nFriday, 6 March 632 CE")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 1)
            }
        }
        #if !os(watchOS)
        .contextMenu {
            Button(action: {
                UIPasteboard.general.string = "All mankind is from Adam and Eve, an Arab has no superiority over a non-Arab nor a non-Arab has any superiority over an Arab; also a white has no superiority over a black, nor a black has any superiority over a white except by piety and good action."
            }) {
                Text("Copy Text")
                Image(systemName: "doc.on.doc")
            }
        }
        #endif
    }
}

struct AlIslamAppsSection: View {
    @EnvironmentObject var settings: Settings
    
    #if !os(watchOS)
    let spacing: CGFloat = 20
    #else
    let spacing: CGFloat = 10
    #endif

    var body: some View {
        Section(header: Text("AL-ISLAMIC APPS")) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.yellow.opacity(0.25), .green.opacity(0.25)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: .primary.opacity(0.25), radius: 5, x: 0, y: 1)
                    .padding(.horizontal, -12)
                
                HStack(spacing: spacing) {
                    Card(
                        title: "Al-Adhan",
                        url: URL(string: "https://apps.apple.com/us/app/al-adhan-prayer-times/id6475015493")!
                    )
                    
                    Card(
                        title: "Al-Islam",
                        url: URL(string: "https://apps.apple.com/us/app/al-islam-islamic-pillars/id6449729655")!
                    )
                    
                    Card(
                        title: "Al-Quran",
                        url: URL(string: "https://apps.apple.com/us/app/al-quran-beginner-quran/id6474894373")!
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .scaledToFit()
                .padding(.vertical, 8)
                .padding(.horizontal)
            }
        }
    }
}

private struct Card: View {
    @EnvironmentObject var settings: Settings
    @Environment(\.openURL) private var openURL
    
    let title: String
    let url: URL

    var body: some View {
        Button(action: {
            settings.hapticFeedback()
            
            openURL(url)
        }) {
            VStack {
                Image(title)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .shadow(radius: 4)

                #if !os(watchOS)
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .padding(.top, 4)
                #endif
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
