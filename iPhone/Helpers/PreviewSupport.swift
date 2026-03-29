import SwiftUI

enum AlIslamPreviewData {
    static let settings: Settings = {
        let settings = Settings.shared
        configure(settings)
        return settings
    }()

    static let quranData = QuranData.shared
    static let quranPlayer = QuranPlayer.shared
    static let namesData = NamesViewModel.shared

    static var surah: Surah {
        quranData.quran.first ?? fallbackSurah
    }

    static var ayah: Ayah {
        surah.ayahs.first(where: { $0.existsInQiraah(settings.displayQiraahForArabic) })
            ?? surah.ayahs.first
            ?? fallbackAyah
    }

    static var juz: Juz {
        QuranData.juzList.first ?? fallbackJuz
    }

    private static func configure(_ settings: Settings) {
        
    }

    private static var fallbackAyah: Ayah {
        Ayah(
            id: 1,
            idArabic: "١",
            textHafs: "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
            textTransliteration: "Bismillahi ar-Rahmani ar-Raheem",
            textEnglishSaheeh: "In the name of Allah, the Entirely Merciful, the Especially Merciful.",
            textEnglishMustafa: "In the Name of Allah, the Most Compassionate, the Most Merciful.",
            juz: 1,
            page: 1,
            textWarsh: nil,
            textQaloon: nil,
            textDuri: nil,
            textBuzzi: nil,
            textQunbul: nil,
            textShubah: nil,
            textSusi: nil
        )
    }

    private static var fallbackSurah: Surah {
        Surah(
            id: 1,
            idArabic: "١",
            nameArabic: "الفاتحة",
            nameTransliteration: "Al-Fatihah",
            nameEnglish: "The Opening",
            type: "meccan",
            numberOfAyahs: 7,
            ayahs: [fallbackAyah]
        )
    }

    private static var fallbackJuz: Juz {
        Juz(
            id: 1,
            nameArabic: "الم",
            nameTransliteration: "Alif Lam Mim",
            startSurah: 1,
            startAyah: 1,
            endSurah: 2,
            endAyah: 141
        )
    }
}

struct AlIslamPreviewContainer<Content: View>: View {
    private let embedInNavigation: Bool
    private let content: Content

    init(embedInNavigation: Bool = true, @ViewBuilder content: () -> Content) {
        self.embedInNavigation = embedInNavigation
        self.content = content()
    }

    var body: some View {
        previewContent
            .accentColor(AlIslamPreviewData.settings.accentColor.color)
            .tint(AlIslamPreviewData.settings.accentColor.color)
            .environmentObject(AlIslamPreviewData.settings)
            .environmentObject(AlIslamPreviewData.quranData)
            .environmentObject(AlIslamPreviewData.quranPlayer)
            .environmentObject(AlIslamPreviewData.namesData)
    }

    @ViewBuilder
    private var previewContent: some View {
        if embedInNavigation {
            NavigationView {
                content
            }
        } else {
            content
        }
    }
}

#Preview {
    AlIslamPreviewContainer(embedInNavigation: false) {
        Text("Preview Support")
            .padding()
    }
}
