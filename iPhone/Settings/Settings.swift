import SwiftUI
import WatchConnectivity

struct LetterData: Identifiable, Codable, Equatable, Comparable {
    let id: Int
    let letter: String
    let forms: [String]
    let name: String
    let transliteration: String
    let showTashkeel: Bool
    let sound: String
    
    static func < (lhs: LetterData, rhs: LetterData) -> Bool {
        return lhs.id < rhs.id
    }
}

extension Date {
    func isSameDay(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: date)
    }
}

enum AccentColor: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }

    case red, orange, yellow, green, blue, indigo, cyan, teal, mint, purple, pink, brown

    var color: Color {
        switch self {
        case .red: return .red
        case .orange: return .orange
        case .yellow: return .yellow
        case .green: return .green
        case .blue: return .blue
        case .indigo: return .indigo
        case .cyan: return .cyan
        case .teal: return .teal
        case .mint: return .mint
        case .purple: return .purple
        case .pink: return .pink
        case .brown: return .brown
        }
    }
}

let accentColors: [AccentColor] = AccentColor.allCases

class Settings: ObservableObject {
    static let shared = Settings()
    private var appGroupUserDefaults: UserDefaults?
    
    init() {
        self.appGroupUserDefaults = UserDefaults(suiteName: "group.com.IslamicPillars.AppGroup")
        
        self.accentColor = AccentColor(rawValue: appGroupUserDefaults?.string(forKey: "colorAccent") ?? "green") ?? .green
        
        self.favoriteSurahsData = appGroupUserDefaults?.data(forKey: "favoriteSurahsData") ?? Data()
        self.bookmarkedAyahsData = appGroupUserDefaults?.data(forKey: "bookmarkedAyahsData") ?? Data()
        self.favoriteLetterData = appGroupUserDefaults?.data(forKey: "favoriteLetterData") ?? Data()
    }
    
    func arabicNumberString(from numberString: String) -> String {
        let arabicNumbers = ["٠", "١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩"]

        var arabicNumberString = ""
        for character in numberString {
            if let digit = Int(String(character)) {
                arabicNumberString += arabicNumbers[digit]
            } else {
                arabicNumberString += String(character)
            }
        }
        return arabicNumberString
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
    
    @Published var favoriteSurahsData: Data {
        didSet {
            appGroupUserDefaults?.setValue(favoriteSurahsData, forKey: "favoriteSurahsData")
        }
    }
    var favoriteSurahs: [Int] {
        get {
            let decoder = JSONDecoder()
            return (try? decoder.decode([Int].self, from: favoriteSurahsData)) ?? []
        }
        set {
            let encoder = JSONEncoder()
            favoriteSurahsData = (try? encoder.encode(newValue)) ?? Data()
        }
    }

    @Published var bookmarkedAyahsData: Data {
        didSet {
            appGroupUserDefaults?.setValue(bookmarkedAyahsData, forKey: "bookmarkedAyahsData")
        }
    }
    var bookmarkedAyahs: [BookmarkedAyah] {
        get {
            let decoder = JSONDecoder()
            return (try? decoder.decode([BookmarkedAyah].self, from: bookmarkedAyahsData)) ?? []
        }
        set {
            let encoder = JSONEncoder()
            bookmarkedAyahsData = (try? encoder.encode(newValue)) ?? Data()
        }
    }

    @Published var favoriteLetterData: Data {
        didSet {
            appGroupUserDefaults?.setValue(favoriteLetterData, forKey: "favoriteLetterData")
        }
    }
    var favoriteLetters: [LetterData] {
        get {
            let decoder = JSONDecoder()
            return (try? decoder.decode([LetterData].self, from: favoriteLetterData)) ?? []
        }
        set {
            let encoder = JSONEncoder()
            favoriteLetterData = (try? encoder.encode(newValue)) ?? Data()
        }
    }
    
    func dictionaryRepresentation() -> [String: Any] {
        let encoder = JSONEncoder()
        var dict: [String: Any] = [
            "accentColor": self.accentColor.rawValue,
                        
            "beginnerMode": self.beginnerMode,
            "lastReadSurah": self.lastReadSurah,
            "lastReadAyah": self.lastReadAyah,
        ]
        
        do {
            dict["favoriteSurahsData"] = try encoder.encode(self.favoriteSurahs)
        } catch {
            print("Error encoding favoriteSurahs: \(error)")
        }

        do {
            dict["bookmarkedAyahsData"] = try encoder.encode(self.bookmarkedAyahs)
        } catch {
            print("Error encoding bookmarkedAyahs: \(error)")
        }

        do {
            dict["favoriteLetterData"] = try encoder.encode(self.favoriteLetters)
        } catch {
            print("Error encoding favoriteLetters: \(error)")
        }
        
        return dict
    }

    func update(from dict: [String: Any]) {
        let decoder = JSONDecoder()
        if let accentColor = dict["accentColor"] as? String,
           let accentColorValue = AccentColor(rawValue: accentColor) {
            self.accentColor = accentColorValue
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
            self.favoriteSurahs = (try? decoder.decode([Int].self, from: favoriteSurahsData)) ?? []
        }
        if let bookmarkedAyahsData = dict["bookmarkedAyahsData"] as? Data {
            self.bookmarkedAyahs = (try? decoder.decode([BookmarkedAyah].self, from: bookmarkedAyahsData)) ?? []
        }
        if let favoriteLetterData = dict["favoriteLetterData"] as? Data {
            self.favoriteLetters = (try? decoder.decode([LetterData].self, from: favoriteLetterData)) ?? []
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

    @AppStorage("useSystemFontSize") var useSystemFontSize: Bool = true

    @AppStorage("groupBySurah") var groupBySurah: Bool = true
    @AppStorage("searchForSurahs") var searchForSurahs: Bool = true

    @AppStorage("reciter") var reciter: String = "ar.minshawi"
    @AppStorage("reciteType") var reciteType = "Continue to Next"
    
    @AppStorage("beginnerMode") var beginnerMode: Bool = false
    
    @AppStorage("lastReadSurah") var lastReadSurah: Int = 0
    @AppStorage("lastReadAyah") var lastReadAyah: Int = 0
    
    @AppStorage("lastListenedSurahData") private var lastListenedSurahData: Data?
    var lastListenedSurah: LastListenedSurah? {
        get {
            guard let data = lastListenedSurahData else { return nil }
            do {
                return try JSONDecoder().decode(LastListenedSurah.self, from: data)
            } catch {
                print("Failed to decode last listened surah: \(error)")
                return nil
            }
        }
        set {
            if let newValue = newValue {
                do {
                    lastListenedSurahData = try JSONEncoder().encode(newValue)
                } catch {
                    print("Failed to encode last listened surah: \(error)")
                }
            } else {
                lastListenedSurahData = nil
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
    
    @AppStorage("englishFontSize") var englishFontSize: Double = Double(UIFont.preferredFont(forTextStyle: .body).pointSize) {
        didSet {
            if useSystemFontSize && englishFontSize != Double(UIFont.preferredFont(forTextStyle: .body).pointSize) {
                useSystemFontSize = false
            }
        }
    }
    
    func toggleSurahFavorite(surah: Surah) {
        withAnimation {
            if isSurahFavorite(surah: surah) {
                favoriteSurahs.removeAll(where: { $0 == surah.id })
            } else {
                favoriteSurahs.append(surah.id)
            }
        }
    }

    func isSurahFavorite(surah: Surah) -> Bool {
        return favoriteSurahs.contains(surah.id)
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

    func isBookmarked(surah: Int, ayah: Int) -> Bool {
        let bookmark = BookmarkedAyah(surah: surah, ayah: ayah)
        return bookmarkedAyahs.contains(where: {$0.id == bookmark.id})
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

struct CustomColorSchemeKey: EnvironmentKey {
    static let defaultValue: ColorScheme? = nil
}

extension EnvironmentValues {
    var customColorScheme: ColorScheme? {
        get { self[CustomColorSchemeKey.self] }
        set { self[CustomColorSchemeKey.self] = newValue }
    }
}

func arabicNumberString(from number: Int) -> String {
    let arabicNumbers = ["٠", "١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩"]
    let numberString = String(number)
    
    var arabicNumberString = ""
    for character in numberString {
        if let digit = Int(String(character)) {
            arabicNumberString += arabicNumbers[digit]
        }
    }
    return arabicNumberString
}
