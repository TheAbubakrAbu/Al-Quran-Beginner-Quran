import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var quranData: QuranData
    
    @State private var showingCredits = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("AL-QURAN")) {
                    NavigationLink(destination:
                        List {
                            SettingsQuranView(showEdits: true)
                                .environmentObject(quranData)
                                .environmentObject(settings)
                        }
                        .applyConditionalListStyle(defaultView: true)
                        .navigationTitle("Al-Quran Settings")
                        .navigationBarTitleDisplayMode(.inline)
                    ) {
                        Label("Quran Settings", systemImage: "character.book.closed.ar")
                    }
                    .accentColor(settings.accentColor.color)
                }
                
                Section(header: Text("APPEARANCE")) {
                    SettingsAppearanceView()
                }
                .accentColor(settings.accentColor.color)
                
                Section(header: Text("CREDITS")) {
                    Text("Made by Abubakr Elmallah, who was a 17-year-old high school student when this app was made.\n\nSpecial thanks to my parents and to Mr. Joe Silvey, my English teacher and Muslim Student Association Advisor.")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    
                    #if !os(watchOS)
                    Button(action: {
                        settings.hapticFeedback()
                        
                        showingCredits = true
                    }) {
                        Label("View Credits", systemImage: "scroll.fill")
                            .font(.subheadline)
                            .foregroundColor(settings.accentColor.color)
                    }
                    .sheet(isPresented: $showingCredits) {
                        CreditsView()
                    }

                    Button(action: {
                        settings.hapticFeedback()
                        
                        withAnimation(.smooth()) {
                            if let url = URL(string: "itms-apps://itunes.apple.com/app/id6474894373?action=write-review") {
                                UIApplication.shared.open(url)
                            }
                        }
                    }) {
                        Label("Leave a Review", systemImage: "star.bubble.fill")
                            .font(.subheadline)
                            .foregroundColor(settings.accentColor.color)
                    }
                    .contextMenu {
                        Button(action: {
                            settings.hapticFeedback()
                            
                            UIPasteboard.general.string = "itms-apps://itunes.apple.com/app/id6474894373?action=write-review"
                        }) {
                            HStack {
                                Image(systemName: "doc.on.doc")
                                Text("Copy Website")
                            }
                        }
                    }

                    Button(action: {
                        settings.hapticFeedback()
                        
                        withAnimation(.smooth()) {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                    }) {
                        Label("Open App Settings", systemImage: "gearshape.fill")
                            .font(.subheadline)
                            .foregroundColor(settings.accentColor.color)
                    }
                    #endif

                    HStack {
                        Text("Website: ")
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .frame(width: glyphWidth)
                        
                        Link("abubakrelmallah.com", destination: URL(string: "https://abubakrelmallah.com/")!)
                            .font(.subheadline)
                            .foregroundColor(settings.accentColor.color)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, -4)
                    }
                    #if !os(watchOS)
                    .contextMenu {
                        Button(action: {
                            UIPasteboard.general.string = "abubakrelmallah.com"
                        }) {
                            HStack {
                                Image(systemName: "doc.on.doc")
                                Text("Copy Website")
                            }
                        }
                    }
                    #endif

                    HStack {
                        Text("Contact: ")
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .frame(width: glyphWidth)
                        
                        Text("ammelmallah@icloud.com")
                            .font(.subheadline)
                            .foregroundColor(settings.accentColor.color)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, -4)
                    }
                    #if !os(watchOS)
                    .contextMenu {
                        Button(action: {
                            UIPasteboard.general.string = "ammelmallah@icloud.com"
                        }) {
                            HStack {
                                Image(systemName: "doc.on.doc")
                                Text("Copy Email")
                            }
                        }
                    }
                    #endif
                }
                
                AlIslamAppsSection()
            }
            .navigationTitle("Settings")
            .applyConditionalListStyle(defaultView: true)
        }
        .navigationViewStyle(.stack)
    }
    
    private func columnWidth(for textStyle: UIFont.TextStyle, extra: CGFloat = 4, sample: String? = nil, fontName: String? = nil) -> CGFloat {
        let sampleString = (sample ?? "M") as NSString
        let font: UIFont

        if let fontName = fontName, let customFont = UIFont(name: fontName, size: UIFont.preferredFont(forTextStyle: textStyle).pointSize) {
            font = customFont
        } else {
            font = UIFont.preferredFont(forTextStyle: textStyle)
        }

        return ceil(sampleString.size(withAttributes: [.font: font]).width) + extra
    }

    private var glyphWidth: CGFloat {
        columnWidth(for: .subheadline, extra: 0, sample: "Contact: ")
    }
}

struct SettingsAppearanceView: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        #if !os(watchOS)
        Picker("Color Theme", selection: $settings.colorSchemeString.animation(.easeInOut)) {
            Text("System").tag("system")
            Text("Light").tag("light")
            Text("Dark").tag("dark")
        }
        .font(.subheadline)
        .pickerStyle(SegmentedPickerStyle())
        #endif
        
        VStack(alignment: .leading) {
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 12),
                GridItem(.flexible(), spacing: 12),
                GridItem(.flexible(), spacing: 12),
                GridItem(.flexible(), spacing: 12),
            ], spacing: 12) {
                ForEach(accentColors, id: \.self) { accentColor in
                    Circle()
                        .fill(accentColor.color)
                        .frame(width: 30, height: 30)
                        .overlay(
                            Circle()
                                .stroke(settings.accentColor == accentColor ? Color.primary : Color.clear, lineWidth: 1)
                        )
                        .onTapGesture {
                            settings.hapticFeedback()
                            
                            withAnimation {
                                settings.accentColor = accentColor
                            }
                        }
                }
            }
            .padding(.vertical)
            
            #if !os(watchOS)
            Text("Anas ibn Malik (may Allah be pleased with him) said, “The most beloved of colors to the Messenger of Allah (peace be upon him) was green.”")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.vertical, 2)
            #endif
        }
        
        #if !os(watchOS)
        VStack(alignment: .leading) {
            Toggle("Default List View", isOn: $settings.defaultView.animation(.easeInOut))
                .font(.subheadline)
            
            Text("The default list view is the standard interface found in many of Apple's first party apps, including Notes. This setting only applies to the Quran and Tools views.")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.vertical, 2)
        }
        #endif
        
        VStack(alignment: .leading) {
            Toggle("Haptic Feedback", isOn: $settings.hapticOn.animation(.easeInOut))
                .font(.subheadline)
        }
    }
}
