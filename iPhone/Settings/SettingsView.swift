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
                        Text("View Credits")
                            .font(.subheadline)
                            .foregroundColor(settings.accentColor.color)
                            .multilineTextAlignment(.center)
                    }
                    .sheet(isPresented: $showingCredits) {
                        NavigationView {
                            VStack {
                                Text("Credits")
                                    .foregroundColor(settings.accentColor.color)
                                    .font(.title)
                                    .padding(.top, 20)
                                    .padding(.bottom, 4)
                                    .padding(.horizontal)
                                
                                CreditsView()
                                
                                Button(action: {
                                    settings.hapticFeedback()
                                    
                                    showingCredits = false
                                }) {
                                    Text("Done")
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(settings.accentColor.color)
                                        .foregroundColor(.primary)
                                        .cornerRadius(10)
                                        .padding(.horizontal, 16)
                                }
                            }
                        }
                    }
                    #endif
                    
                    HStack {
                        Text("Contact me at: ")
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                        
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
            }
            .navigationTitle("Settings")
            .applyConditionalListStyle(defaultView: true)
        }
        .navigationViewStyle(.stack)
    }
}

struct SettingsQuranView: View {
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var quranData: QuranData
    
    @State private var showEdits: Bool

    init(showEdits: Bool = false) {
        _showEdits = State(initialValue: showEdits)
    }
    
    var body: some View {
        Section(header: Text("RECITATION")) {
            Picker("Reciter", selection: $settings.reciter.animation(.easeInOut)) {
                ForEach(reciters, id: \.ayahIdentifier) { reciter in
                    Text(reciter.name).tag(reciter.ayahIdentifier)
                }
            }
            .font(.subheadline)
            
            Picker("After Surah Recitation Ends", selection: $settings.reciteType.animation(.easeInOut)) {
                Text("Continue to Next").tag("Continue to Next")
                Text("Continue to Previous").tag("Continue to Previous")
                Text("End Recitation").tag("End Recitation")
            }
            .font(.subheadline)
            
            Text("The Quran recitations are streamed online and not downloaded, which may consume a lot of data if used frequently, especially when using cellular data.")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        
        Section(header: Text("ARABIC TEXT")) {
            Toggle("Show Arabic Quran Text", isOn: $settings.showArabicText.animation(.easeInOut))
                .font(.subheadline)
                .tint(settings.accentColor.color)
                .disabled(!settings.showTransliteration && !settings.showEnglishTranslation)
            
            if settings.showArabicText {
                VStack(alignment: .leading) {
                    Toggle("Remove Arabic Tashkeel (Vowel Diacritics) and Signs", isOn: $settings.cleanArabicText.animation(.easeInOut))
                        .font(.subheadline)
                        .tint(settings.accentColor.color)
                        .disabled(!settings.showArabicText)
                    
                    #if !os(watchOS)
                    Text("This option removes Tashkeel, which are vowel diacretic marks such as Fatha, Damma, Kasra, and others, while retaining essential vowels like Alif, Yaa, and Waw. It also adjusts \"Mad\" letters and the \"Hamzatul Wasl,\" and removes baby vowel letters, various textual annotations including stopping signs, chapter markers, and prayer indicators. This option is not recommended.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 2)
                    #else
                    Text("This option removes Tashkeel (vowel diacretics).")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 2)
                    #endif
                }
                
                Picker("Arabic Font", selection: $settings.fontArabic.animation(.easeInOut)) {
                    Text("Uthmani").tag("KFGQPCHafsEx1UthmanicScript-Reg")
                    Text("Indopak").tag("Al_Mushaf")
                }
                #if !os(watchOS)
                .pickerStyle(SegmentedPickerStyle())
                #endif
                .disabled(!settings.showArabicText)
                
                Stepper(value: $settings.fontArabicSize.animation(.easeInOut), in: 15...50, step: 2) {
                    Text("Arabic Font Size: \(Int(settings.fontArabicSize))")
                        .font(.subheadline)
                }
                
                VStack(alignment: .leading) {
                    Toggle("Enable Arabic Beginner Mode", isOn: $settings.beginnerMode.animation(.easeInOut))
                        .font(.subheadline)
                        .tint(settings.accentColor.color)
                        .disabled(!settings.showArabicText)
                    
                    Text("Puts a space between each Arabic letter to make it easier for beginners to read the Quran.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 2)
                }
            }
        }
        
        Section(header: Text("ENGLISH TEXT")) {
            Toggle("Show Transliteration", isOn: $settings.showTransliteration.animation(.easeInOut))
                .font(.subheadline)
                .tint(settings.accentColor.color)
                .disabled(!settings.showArabicText && !settings.showEnglishTranslation)
            
            Toggle("Show English Translation", isOn: $settings.showEnglishTranslation.animation(.easeInOut))
                .font(.subheadline)
                .tint(settings.accentColor.color)
                .disabled(!settings.showArabicText && !settings.showTransliteration)
            
            if settings.showTransliteration || settings.showEnglishTranslation {
                Stepper(value: $settings.englishFontSize.animation(.easeInOut), in: 13...20, step: 1) {
                    Text("English Font Size: \(Int(settings.englishFontSize))")
                        .font(.subheadline)
                }
            }
            
            Toggle("Use System Font Size", isOn: $settings.useSystemFontSize.animation(.easeInOut))
                .font(.subheadline)
                .tint(settings.accentColor.color)
                .onChange(of: settings.useSystemFontSize) { useSystemFontSize in
                    if useSystemFontSize {
                        settings.englishFontSize = UIFont.preferredFont(forTextStyle: .body).pointSize
                    }
                }
                .onChange(of: settings.englishFontSize) { newValue in
                    if newValue == UIFont.preferredFont(forTextStyle: .body).pointSize {
                        settings.useSystemFontSize = true
                    }
                }
        }
        
        #if !os(watchOS)
        if showEdits {
            Section(header: Text("FAVORITES AND BOOKMARKS")) {
                NavigationLink(destination: FavoritesView(type: .surah).environmentObject(quranData).accentColor(settings.accentColor.color)) {
                    Text("Edit Favorite Surahs")
                        .font(.subheadline)
                        .foregroundColor(settings.accentColor.color)
                }
                
                NavigationLink(destination: FavoritesView(type: .ayah).environmentObject(quranData).accentColor(settings.accentColor.color)) {
                    Text("Edit Bookmarked Ayahs")
                        .font(.subheadline)
                        .foregroundColor(settings.accentColor.color)
                }
                
                NavigationLink(destination: FavoritesView(type: .letter).environmentObject(quranData).accentColor(settings.accentColor.color)) {
                    Text("Edit Favorite Letters")
                        .font(.subheadline)
                        .foregroundColor(settings.accentColor.color)
                }
            }
        }
        #endif
    }
}

#if !os(watchOS)
enum FavoriteType {
    case surah, ayah, letter
}

struct FavoritesView: View {
    @EnvironmentObject var quranData: QuranData
    @EnvironmentObject var settings: Settings
    
    @State private var editMode: EditMode = .inactive

    let type: FavoriteType

    var body: some View {
        List {
            switch type {
            case .surah:
                if settings.favoriteSurahs.isEmpty {
                    Text("No favorite surahs here, long tap a surah to favorite it.")
                } else {
                    ForEach(settings.favoriteSurahs.sorted(), id: \.self) { surahId in
                        if let surah = quranData.quran.first(where: { $0.id == surahId }) {
                            SurahRow(surah: surah)
                        }
                    }
                    .onDelete(perform: removeSurahs)
                }
            case .ayah:
                if settings.bookmarkedAyahs.isEmpty {
                    Text("No bookmarked ayahs here, long tap an ayah to bookmark it.")
                } else {
                    ForEach(settings.bookmarkedAyahs.sorted {
                        if $0.surah == $1.surah {
                            return $0.ayah < $1.ayah
                        } else {
                            return $0.surah < $1.surah
                        }
                    }, id: \.id) { bookmarkedAyah in
                        let surah = quranData.quran.first(where: { $0.id == bookmarkedAyah.surah })
                        let ayah = surah?.ayahs.first(where: { $0.id == bookmarkedAyah.ayah })
                        
                        if let ayah = ayah {
                            HStack {
                                Text("\(bookmarkedAyah.surah):\(bookmarkedAyah.ayah)")
                                    .font(.headline)
                                    .foregroundColor(settings.accentColor.color)
                                    .padding(.trailing, 8)
                                
                                VStack {
                                    if(settings.showArabicText) {
                                        Text(ayah.textArabic)
                                            .font(.custom(settings.fontArabic, size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize * 1.1))
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .lineLimit(1)
                                    }
                                    
                                    if(settings.showTransliteration) {
                                        Text(ayah.textTransliteration ?? "")
                                            .font(.subheadline)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .lineLimit(1)
                                    }
                                    
                                    if(settings.showEnglishTranslation) {
                                        Text(ayah.textEnglish ?? "")
                                            .font(.subheadline)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .lineLimit(1)
                                    }
                                }
                                .padding(.vertical, 2)
                            }
                        }
                    }
                    .onDelete(perform: removeAyahs)
                }
            case .letter:
                if settings.favoriteLetters.isEmpty {
                    Text("No favorite letters here, long tap a letter to favorite it.")
                } else {
                    ForEach(settings.favoriteLetters.sorted(), id: \.id) { favorite in
                        ArabicLetterRow(letterData: favorite)
                    }
                    .onDelete(perform: removeLetters)
                }
            }
            
            Section {
                if !isListEmpty {
                    Button("Delete All") {
                        deleteAll()
                    }
                    .foregroundColor(.red)
                }
            }
        }
        .applyConditionalListStyle(defaultView: true)
        .navigationTitle(titleForFavoriteType(type))
        .toolbar {
            EditButton()
        }
        .environment(\.editMode, $editMode)
    }

    private var isListEmpty: Bool {
        switch type {
        case .surah: return settings.favoriteSurahs.isEmpty
        case .ayah: return settings.bookmarkedAyahs.isEmpty
        case .letter: return settings.favoriteLetters.isEmpty
        }
    }

    private func deleteAll() {
        switch type {
        case .surah:
            settings.favoriteSurahs.removeAll()
        case .ayah:
            settings.bookmarkedAyahs.removeAll()
        case .letter:
            settings.favoriteLetters.removeAll()
        }
    }
    
    private func removeSurahs(at offsets: IndexSet) {
        settings.favoriteSurahs.remove(atOffsets: offsets)
    }

    private func removeAyahs(at offsets: IndexSet) {
        settings.bookmarkedAyahs.remove(atOffsets: offsets)
    }

    private func removeLetters(at offsets: IndexSet) {
        settings.favoriteLetters.remove(atOffsets: offsets)
    }
    
    private func titleForFavoriteType(_ type: FavoriteType) -> String {
        switch type {
        case .surah:
            return "Favorite Surahs"
        case .ayah:
            return "Bookmarked Ayahs"
        case .letter:
            return "Favorite Letters"
        }
    }
}
#endif

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
                .tint(settings.accentColor.color)
            
            Text("The default list view is the standard interface found in many of Apple's first party apps, including Notes. This setting only applies to the main view.")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.vertical, 2)
        }
        #endif
        
        VStack(alignment: .leading) {
            Toggle("Haptic Feedback", isOn: $settings.hapticOn.animation(.easeInOut))
                .font(.subheadline)
                .tint(settings.accentColor.color)
        }
    }
}
