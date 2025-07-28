import SwiftUI
import os

let logger = Logger(subsystem: "com.Quran.Elmallah.Beginner-Quran", category: "Al-Quran")

final class Settings: ObservableObject {
    static let shared = Settings()
    
    private var appGroupUserDefaults: UserDefaults?
    
    static let encoder: JSONEncoder = JSONEncoder()
    static let decoder: JSONDecoder = JSONDecoder()
    
    private static let arabicDigits = ["٠","١","٢","٣","٤","٥","٦","٧","٨","٩"]
    
    private init() {
        self.appGroupUserDefaults = UserDefaults(suiteName: "group.com.IslamicPillars.AppGroup")
        
        self.accentColor = AccentColor(rawValue: appGroupUserDefaults?.string(forKey: "colorAccent") ?? "green") ?? .green
        
        if let reciterID = appGroupUserDefaults?.string(forKey: "reciterQuran"), reciterID.starts(with: "ar"),
           let reciter = reciters.first(where: { $0.ayahIdentifier == reciterID }) {
            self.reciter = reciter.name
        } else {
            self.reciter = appGroupUserDefaults?.string(forKey: "reciterQuran") ?? "Muhammad Al-Minshawi (Murattal)"
        }
        
        self.reciteType = appGroupUserDefaults?.string(forKey: "reciteTypeQuran") ?? "Continue to Next"
        
        self.favoriteSurahsData = appGroupUserDefaults?.data(forKey: "favoriteSurahsData") ?? Data()
        self.bookmarkedAyahsData = appGroupUserDefaults?.data(forKey: "bookmarkedAyahsData") ?? Data()
        self.favoriteLetterData = appGroupUserDefaults?.data(forKey: "favoriteLetterData") ?? Data()
        
        withAnimation {
            self.favoriteSurahsCopy = self.favoriteSurahs
            self.bookmarkedAyahsCopy = self.bookmarkedAyahs
        }
    }
    
    func hapticFeedback() {
        #if os(iOS)
        if hapticOn { UIImpactFeedbackGenerator(style: .light).impactOccurred() }
        #endif
        
        #if os(watchOS)
        if hapticOn { WKInterfaceDevice.current().play(.click) }
        #endif
    }
    
    @Published var accentColor: AccentColor {
        didSet { appGroupUserDefaults?.setValue(accentColor.rawValue, forKey: "colorAccent") }
    }
    
    @Published var reciter: String {
        didSet { appGroupUserDefaults?.setValue(reciter, forKey: "reciterQuran") }
    }
    
    @Published var reciteType: String {
        didSet { appGroupUserDefaults?.setValue(reciteType, forKey: "reciteTypeQuran") }
    }
    
    @Published var favoriteSurahsData: Data {
        didSet {
            appGroupUserDefaults?.setValue(favoriteSurahsData, forKey: "favoriteSurahsData")
        }
    }
    var favoriteSurahs: [Int] {
        get {
            return (try? Self.decoder.decode([Int].self, from: favoriteSurahsData)) ?? []
        }
        set {
            favoriteSurahsData = (try? Self.encoder.encode(newValue)) ?? Data()
        }
    }
    
    @Published var favoriteSurahsCopy: [Int] = []

    @Published var bookmarkedAyahsData: Data {
        didSet {
            appGroupUserDefaults?.setValue(bookmarkedAyahsData, forKey: "bookmarkedAyahsData")
        }
    }
    var bookmarkedAyahs: [BookmarkedAyah] {
        get {
            return (try? Self.decoder.decode([BookmarkedAyah].self, from: bookmarkedAyahsData)) ?? []
        }
        set {
            bookmarkedAyahsData = (try? Self.encoder.encode(newValue)) ?? Data()
        }
    }
    
    @Published var bookmarkedAyahsCopy: [BookmarkedAyah] = []
    
    @AppStorage("showBookmarks") var showBookmarks = true
    @AppStorage("showFavorites") var showFavorites = true

    @Published var favoriteLetterData: Data {
        didSet {
            appGroupUserDefaults?.setValue(favoriteLetterData, forKey: "favoriteLetterData")
        }
    }
    var favoriteLetters: [LetterData] {
        get {
            return (try? Self.decoder.decode([LetterData].self, from: favoriteLetterData)) ?? []
        }
        set {
            favoriteLetterData = (try? Self.encoder.encode(newValue)) ?? Data()
        }
    }
    
    func dictionaryRepresentation() -> [String: Any] {
        var dict: [String: Any] = [
            "accentColor": self.accentColor.rawValue,
            "reciter": self.reciter,
            "reciteType": self.reciteType,
            
            "beginnerMode": self.beginnerMode,
            "lastReadSurah": self.lastReadSurah,
            "lastReadAyah": self.lastReadAyah,
        ]
        
        do {
            dict["favoriteSurahsData"] = try Self.encoder.encode(self.favoriteSurahs)
        } catch {
            logger.debug("Error encoding favoriteSurahs: \(error)")
        }

        do {
            dict["bookmarkedAyahsData"] = try Self.encoder.encode(self.bookmarkedAyahs)
        } catch {
            logger.debug("Error encoding bookmarkedAyahs: \(error)")
        }

        do {
            dict["favoriteLetterData"] = try Self.encoder.encode(self.favoriteLetters)
        } catch {
            logger.debug("Error encoding favoriteLetters: \(error)")
        }
        
        return dict
    }

    func update(from dict: [String: Any]) {
        if let accentColor = dict["accentColor"] as? String,
           let accentColorValue = AccentColor(rawValue: accentColor) {
            self.accentColor = accentColorValue
        }
        if let reciter = dict["reciter"] as? String {
            self.reciter = reciter
        }
        if let reciteType = dict["reciteType"] as? String {
            self.reciteType = reciteType
        }
        if let beginnerMode = dict["beginnerMode"] as? Bool {
            self.beginnerMode = beginnerMode
        }
        if let lastReadSurah = dict["lastReadSurah"] as? Int {
            self.lastReadSurah = lastReadSurah
        }
        if let lastReadAyah = dict["lastReadAyah"] as? Int {
            self.lastReadAyah = lastReadAyah
        }
        if let favoriteSurahsData = dict["favoriteSurahsData"] as? Data {
            self.favoriteSurahs = (try? Self.decoder.decode([Int].self, from: favoriteSurahsData)) ?? []
        }
        if let bookmarkedAyahsData = dict["bookmarkedAyahsData"] as? Data {
            self.bookmarkedAyahs = (try? Self.decoder.decode([BookmarkedAyah].self, from: bookmarkedAyahsData)) ?? []
        }
        if let favoriteLetterData = dict["favoriteLetterData"] as? Data {
            self.favoriteLetters = (try? Self.decoder.decode([LetterData].self, from: favoriteLetterData)) ?? []
        }
    }
    
    @AppStorage("hapticOn") var hapticOn: Bool = true
    
    @AppStorage("defaultView") var defaultView: Bool = true
    
    @AppStorage("firstLaunch") var firstLaunch = true
    
    @AppStorage("colorSchemeString") var colorSchemeString: String = "system"
    var colorScheme: ColorScheme? {
        get {
            return colorSchemeFromString(colorSchemeString)
        }
        set {
            colorSchemeString = colorSchemeToString(newValue)
        }
    }

    @AppStorage("groupBySurah") var groupBySurah: Bool = true
    @AppStorage("searchForSurahs") var searchForSurahs: Bool = true
    
    @AppStorage("beginnerMode") var beginnerMode: Bool = false
    
    @AppStorage("lastReadSurah") var lastReadSurah: Int = 0
    @AppStorage("lastReadAyah") var lastReadAyah: Int = 0
    
    var lastListenedSurah: LastListenedSurah? {
        get {
            guard let data = appGroupUserDefaults?.data(forKey: "lastListenedSurahDataQuran") else { return nil }
            do {
                return try Self.decoder.decode(LastListenedSurah.self, from: data)
            } catch {
                logger.debug("Failed to decode last listened surah: \(error)")
                return nil
            }
        }
        set {
            if let newValue = newValue {
                do {
                    let data = try Self.encoder.encode(newValue)
                    appGroupUserDefaults?.set(data, forKey: "lastListenedSurahDataQuran")
                } catch {
                    logger.debug("Failed to encode last listened surah: \(error)")
                }
            } else {
                appGroupUserDefaults?.removeObject(forKey: "lastListenedSurahDataQuran")
            }
        }
    }
    
    @AppStorage("showArabicText") var showArabicText: Bool = true
    @AppStorage("cleanArabicText") var cleanArabicText: Bool = false
    @AppStorage("fontArabic") var fontArabic: String = "KFGQPCHafsEx1UthmanicScript-Reg"
    @AppStorage("fontArabicSize") var fontArabicSize: Double = Double(UIFont.preferredFont(forTextStyle: .body).pointSize) + 10
    
    @AppStorage("useFontArabic") var useFontArabic = true

    @AppStorage("showTransliteration") var showTransliteration: Bool = true
    @AppStorage("showEnglishTranslation") var showEnglishTranslation: Bool = true
    
    @AppStorage("englishFontSize") var englishFontSize: Double = Double(UIFont.preferredFont(forTextStyle: .body).pointSize)
    
    func toggleSurahFavorite(surah: Int) {
        withAnimation {
            if isSurahFavorite(surah: surah) {
                favoriteSurahs.removeAll(where: { $0 == surah })
            } else {
                favoriteSurahs.append(surah)
            }
        }
    }
    
    func toggleSurahFavoriteCopy(surah: Int) {
        withAnimation {
            if isSurahFavoriteCopy(surah: surah) {
                favoriteSurahsCopy.removeAll(where: { $0 == surah })
            } else {
                favoriteSurahsCopy.append(surah)
            }
        }
    }

    func isSurahFavorite(surah: Int) -> Bool {
        return favoriteSurahs.contains(surah)
    }
    
    func isSurahFavoriteCopy(surah: Int) -> Bool {
        return favoriteSurahsCopy.contains(surah)
    }

    func toggleBookmark(surah: Int, ayah: Int) {
        withAnimation {
            let bookmark = BookmarkedAyah(surah: surah, ayah: ayah)
            if let index = bookmarkedAyahs.firstIndex(where: {$0.id == bookmark.id}) {
                bookmarkedAyahs.remove(at: index)
            } else {
                bookmarkedAyahs.append(bookmark)
            }
        }
    }
    
    func toggleBookmarkCopy(surah: Int, ayah: Int) {
        withAnimation {
            let bookmark = BookmarkedAyah(surah: surah, ayah: ayah)
            if let index = bookmarkedAyahsCopy.firstIndex(where: {$0.id == bookmark.id}) {
                bookmarkedAyahsCopy.remove(at: index)
            } else {
                bookmarkedAyahsCopy.append(bookmark)
            }
        }
    }

    func isBookmarked(surah: Int, ayah: Int) -> Bool {
        let bookmark = BookmarkedAyah(surah: surah, ayah: ayah)
        return bookmarkedAyahs.contains(where: {$0.id == bookmark.id})
    }
    
    func isBookmarkedCopy(surah: Int, ayah: Int) -> Bool {
        let bookmark = BookmarkedAyah(surah: surah, ayah: ayah)
        return bookmarkedAyahsCopy.contains(where: {$0.id == bookmark.id})
    }

    func toggleLetterFavorite(letterData: LetterData) {
        withAnimation {
            if isLetterFavorite(letterData: letterData) {
                favoriteLetters.removeAll(where: { $0.id == letterData.id })
            } else {
                favoriteLetters.append(letterData)
            }
        }
    }

    func isLetterFavorite(letterData: LetterData) -> Bool {
        return favoriteLetters.contains(where: {$0.id == letterData.id})
    }
    
    private static let unwantedCharSet: CharacterSet = {
        CharacterSet(charactersIn: "-[]()'\"").union(.nonBaseCharacters)
    }()

    func cleanSearch(_ text: String, whitespace: Bool = false) -> String {
        var cleaned = String(text.unicodeScalars
            .filter { !Self.unwantedCharSet.contains($0) }
        ).lowercased()

        if whitespace {
            cleaned = cleaned.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        return cleaned
    }
    
    func colorSchemeFromString(_ colorScheme: String) -> ColorScheme? {
        switch colorScheme {
        case "light":
            return .light
        case "dark":
            return .dark
        default:
            return nil
        }
    }

    func colorSchemeToString(_ colorScheme: ColorScheme?) -> String {
        switch colorScheme {
        case .light:
            return "light"
        case .dark:
            return "dark"
        default:
            return "system"
        }
    }
}
