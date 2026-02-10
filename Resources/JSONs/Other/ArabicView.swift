import SwiftUI

class LetterDataFactory {
    private var idCounter = 1

    func makeLetterData(letter: String, forms: [String], name: String, transliteration: String, showTashkeel: Bool, sound: String) -> LetterData {
        let data = LetterData(id: idCounter, letter: letter, forms: forms, name: name, transliteration: transliteration, showTashkeel: showTashkeel, sound: sound)
        idCounter += 1
        return data
    }
}

let factory = LetterDataFactory()

let standardArabicLetters = [
    factory.makeLetterData(letter: "ا", forms: ["ـا", "ـا ـ", "ا ـ"], name: "اَلِف", transliteration: "alif", showTashkeel: false, sound: "a"),
    factory.makeLetterData(letter: "ب", forms: ["ـب", "ـبـ", "بـ"], name: "بَاء", transliteration: "baa", showTashkeel: true, sound: "b"),
    factory.makeLetterData(letter: "ت", forms: ["ـت", "ـتـ", "تـ"], name: "تَاء", transliteration: "taa", showTashkeel: true, sound: "t"),
    factory.makeLetterData(letter: "ث", forms: ["ـث", "ـثـ", "ثـ"], name: "ثَاء", transliteration: "thaa", showTashkeel: true, sound: "th"),
    factory.makeLetterData(letter: "ج", forms: ["ـج", "ـجـ", "جـ"], name: "جِيم", transliteration: "jeem", showTashkeel: true, sound: "j"),
    factory.makeLetterData(letter: "ح", forms: ["ـح", "ـحـ", "حـ"], name: "حَاء", transliteration: "Haa", showTashkeel: true, sound: "H"),
    factory.makeLetterData(letter: "خ", forms: ["ـخ", "ـخـ", "خـ"], name: "خَاء", transliteration: "khaa", showTashkeel: true, sound: "kh"),
    factory.makeLetterData(letter: "د", forms: ["ـد", "ـد ـ", "د ـ"], name: "دَال", transliteration: "daal", showTashkeel: true, sound: "d"),
    factory.makeLetterData(letter: "ذ", forms: ["ـذ", "ـذ ـ", "ذ ـ"], name: "ذَال", transliteration: "dhaal", showTashkeel: true, sound: "dh"),
    factory.makeLetterData(letter: "ر", forms: ["ـر", "ـر ـ", "ر ـ"], name: "رَاء", transliteration: "raa", showTashkeel: true, sound: "r"),
    factory.makeLetterData(letter: "ز", forms: ["ـز", "ـز ـ", "ز ـ"], name: "زَاي", transliteration: "zay", showTashkeel: true, sound: "z"),
    factory.makeLetterData(letter: "س", forms: ["ـس", "ـسـ", "سـ"], name: "سِين", transliteration: "seen", showTashkeel: true, sound: "s"),
    factory.makeLetterData(letter: "ش", forms: ["ـش", "ـشـ", "شـ"], name: "شِين", transliteration: "sheen", showTashkeel: true, sound: "sh"),
    factory.makeLetterData(letter: "ص", forms: ["ـص", "ـصـ", "صـ"], name: "صَاد", transliteration: "Saad", showTashkeel: true, sound: "S"),
    factory.makeLetterData(letter: "ض", forms: ["ـض", "ـضـ", "ضـ"], name: "ضَاد", transliteration: "Daad", showTashkeel: true, sound: "D"),
    factory.makeLetterData(letter: "ط", forms: ["ـط", "ـطـ", "طـ"], name: "طَاء", transliteration: "Taa", showTashkeel: true, sound: "T"),
    factory.makeLetterData(letter: "ظ", forms: ["ـظ", "ـظـ", "ظـ"], name: "ظَاء", transliteration: "Dhaa", showTashkeel: true, sound: "Dh"),
    factory.makeLetterData(letter: "ع", forms: ["ـع", "ـعـ", "عـ"], name: "عَين", transliteration: "'ayn", showTashkeel: true, sound: "'a"),
    factory.makeLetterData(letter: "غ", forms: ["ـغ", "ـغـ", "غـ"], name: "غَين", transliteration: "ghayn", showTashkeel: true, sound: "gh"),
    factory.makeLetterData(letter: "ف", forms: ["ـف", "ـفـ", "فـ"], name: "فَاء", transliteration: "faa", showTashkeel: true, sound: "f"),
    factory.makeLetterData(letter: "ق", forms: ["ـق", "ـقـ", "قـ"], name: "قَاف", transliteration: "qaaf", showTashkeel: true, sound: "q"),
    factory.makeLetterData(letter: "ك", forms: ["ـك", "ـكـ", "كـ"], name: "كَاف", transliteration: "kaaf", showTashkeel: true, sound: "k"),
    factory.makeLetterData(letter: "ل", forms: ["ـل", "ـلـ", "لـ"], name: "لَام", transliteration: "laam", showTashkeel: true, sound: "l"),
    factory.makeLetterData(letter: "م", forms: ["ـم", "ـمـ", "مـ"], name: "مِيم", transliteration: "meem", showTashkeel: true, sound: "m"),
    factory.makeLetterData(letter: "ن", forms: ["ـن", "ـنـ", "نـ"], name: "نُون", transliteration: "noon", showTashkeel: true, sound: "n"),
    factory.makeLetterData(letter: "ه", forms: ["ـه", "ـهـ", "هـ"], name: "هَاء", transliteration: "haa", showTashkeel: true, sound: "h"),
    factory.makeLetterData(letter: "و", forms: ["ـو", "ـو ـ", "و ـ"], name: "وَاو", transliteration: "waw", showTashkeel: true, sound: "w"),
    factory.makeLetterData(letter: "ي", forms: ["ـي", "ـيـ", "يـ"], name: "يَاء", transliteration: "yaa", showTashkeel: true, sound: "y"),
]

let otherArabicLetters = [
    factory.makeLetterData(letter: "ة", forms: ["ـة", "ـة ـ", "ة ـ"], name: "تَاء مَربُوطَة", transliteration: "taa marbuuTa", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "ء", forms: ["ـ ء", "ـ ء ـ", "ء ـ"], name: "هَمزَة", transliteration: "hamza", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "أ", forms: ["ـأ", "ـأ ـ", "أ ـ"], name: "هَمزَة عَلَى أَلِف", transliteration: "hamza on alif", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "إ", forms: ["ـإ", "ـإ ـ", "إ ـ"], name: "هَمزَة عَلَى أَلِف", transliteration: "hamza on alif", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "ئ", forms: ["ـئ", "ـئ ـ", "ئ ـ"], name: "هَمزَة عَلَى يَاء", transliteration: "hamza on yaa", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "ؤ", forms: ["ـؤ", "ـؤ ـ", "ؤ ـ"], name: "هَمزَة عَلَى وَاو", transliteration: "hamza on waw", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "ٱ", forms: ["ٱـ", "ـٱ", "ـٱـ"], name: "هَمزَة الوَصل", transliteration: "hamzatul waSl", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "آ", forms: ["ـآ", "ـآ ـ", "آ ـ"], name: "أَلِف مَدَّ", transliteration: "alif mad", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "يٓ", forms: ["ـيٓ", "ـيٓـ", "يٓـ"], name: "يَاء مَدّ", transliteration: "yaa mad", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "وٓ", forms: ["ـوٓ", "ـوٓـ", "وٓـ"], name: "واو مَدّ", transliteration: "waw mad", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "ى", forms: ["ـى", "ـى ـ", "ى ـ"], name: "أَلِف مَقصُورَة", transliteration: "alif maqSoorah", showTashkeel: false, sound: ""),
    factory.makeLetterData(letter: "ل ا - لا", forms: ["ـلا", "ـلا ـ", "لا ـ"], name: "لَاء", transliteration: "laa", showTashkeel: false, sound: ""),
]

let numbers = [
    (number: "٠", name: "صِفر", transliteration: "sifr", englishNumber: "0"),
    (number: "١", name: "وَاحِد", transliteration: "waahid", englishNumber: "1"),
    (number: "٢", name: "اِثنَين", transliteration: "ithnaan", englishNumber: "2"),
    (number: "٣", name: "ثَلاثَة", transliteration: "thalaathah", englishNumber: "3"),
    (number: "٤", name: "أَربَعَة", transliteration: "arbaʿah", englishNumber: "4"),
    (number: "٥", name: "خَمسَة", transliteration: "khamsah", englishNumber: "5"),
    (number: "٦", name: "سِتَّة", transliteration: "sittah", englishNumber: "6"),
    (number: "٧", name: "سَبعَة", transliteration: "sabʿah", englishNumber: "7"),
    (number: "٨", name: "ثَمانِيَة", transliteration: "thamaaniyah", englishNumber: "8"),
    (number: "٩", name: "تِسعَة", transliteration: "tisʿah", englishNumber: "9"),
    (number: "١٠", name: "عَشَرَة", transliteration: "ʿasharah", englishNumber: "10"),
]

let tashkeels = [
    Tashkeel(english: "Fatha", arabic: "فَتْحَة", tashkeelMark: "َ", transliteration: "a"),
    Tashkeel(english: "Kasra", arabic: "كَسْرَة", tashkeelMark: "ِ", transliteration: "i"),
    Tashkeel(english: "Damma", arabic: "ضَمَّة", tashkeelMark: "ُ", transliteration: "u"),
    
    Tashkeel(english: "Fathatayn", arabic: "فَتْحَتَيْن", tashkeelMark: "ًا", transliteration: "an"),
    Tashkeel(english: "Kasratayn", arabic: "كَسْرَتَيْن", tashkeelMark: "ٍ", transliteration: "in"),
    Tashkeel(english: "Dammatayn", arabic: "ضَمَّتَيْن", tashkeelMark: "ٌ", transliteration: "un"),
    
    Tashkeel(english: "Alif", arabic: "أَلِف", tashkeelMark: "َا", transliteration: "aa"),
    Tashkeel(english: "Yaa", arabic: "يَاء", tashkeelMark: "ِي", transliteration: "ii"),
    Tashkeel(english: "Waw", arabic: "وَاو", tashkeelMark: "ُو", transliteration: "uu"),
    
    Tashkeel(english: "Dagger Alif", arabic: "ألف خنجرية", tashkeelMark: "َٰ", transliteration: "aa"),
    Tashkeel(english: "Miniature Yaa", arabic: "يَاء صغيرة", tashkeelMark: "ِۦ", transliteration: "ii"),
    Tashkeel(english: "Miniature Waw", arabic: "واو صغيرة", tashkeelMark: "ُۥ", transliteration: "uu"),
    
    Tashkeel(english: "Alif Mad", arabic: "أَلِف مَدّ", tashkeelMark: "َآ", transliteration: "aaaa"),
    Tashkeel(english: "Yaa Mad", arabic: "يَاء مَدّ", tashkeelMark: "ِيٓ", transliteration: "iiii"),
    Tashkeel(english: "Waw Mad", arabic: "واو مَدّ", tashkeelMark: "ُوٓ", transliteration: "uuuu"),

    Tashkeel(english: "Alif Maqsoorah", arabic: "ياء بلا نقاط", tashkeelMark: "َى", transliteration: "aa"),
    Tashkeel(english: "Shaddah", arabic: "شَدَّة", tashkeelMark: "ّ", transliteration: ""),
    Tashkeel(english: "Sukoon", arabic: "سُكُون", tashkeelMark: "ْ", transliteration: "")
]

struct Tashkeel {
    let english: String
    let arabic: String
    let tashkeelMark: String
    let transliteration: String
}

struct LetterSectionHeader: View {
    @EnvironmentObject var settings: Settings
    
    let letterData: LetterData
    
    var body: some View {
        HStack {
            Text("LETTER")
                .font(.subheadline)
            
            Spacer()
            
            Image(systemName: settings.isLetterFavorite(letterData: letterData) ? "star.fill" : "star")
                .foregroundColor(settings.colorAccent.color)
                .font(.subheadline)
                .onTapGesture {
                    settings.hapticFeedback()

                    settings.toggleLetterFavorite(letterData: letterData)
                }
        }
    }
}

struct ArabicLetterRow: View {
    @EnvironmentObject var settings: Settings
    
    let letterData: LetterData
    
    var body: some View {
        VStack {
            NavigationLink(destination: ArabicLetterView(letterData: letterData)) {
                HStack {
                    Text(letterData.transliteration)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Text(letterData.letter)
                        .font(.custom(settings.fontArabic, size: UIFont.preferredFont(forTextStyle: .title3).pointSize))
                        .foregroundColor(settings.colorAccent.color)
                }
                #if !os(watchOS)
                .contextMenu {
                    Button(role: settings.isLetterFavorite(letterData: letterData) ? .destructive : nil, action: {
                        settings.hapticFeedback()
                        
                        settings.toggleLetterFavorite(letterData: letterData)
                    }) {
                        Label(settings.isLetterFavorite(letterData: letterData) ? "Unfavorite Letter" : "Favorite Letter", systemImage: settings.isLetterFavorite(letterData: letterData) ? "star.fill" : "star")
                    }
                    
                    Button(action: {
                        UIPasteboard.general.string = letterData.letter
                        settings.hapticFeedback()
                    }) {
                        Label("Copy Letter", systemImage: "doc.on.doc")
                    }
                        
                    Button(action: {
                        UIPasteboard.general.string = letterData.transliteration
                        settings.hapticFeedback()
                    }) {
                        Label("Copy Transliteration", systemImage: "doc.on.doc")
                    }
                }
                #endif
            }
        }
    }
}

struct ArabicNumberRow: View {
    @EnvironmentObject var settings: Settings
    
    let numberData: (number: String, name: String, transliteration: String, englishNumber: String)
    
    var body: some View {
        HStack {
            Text(numberData.englishNumber)
                .font(.title3)
            
            Spacer()
            
            VStack(alignment: .center) {
                Text(numberData.name)
                    .font(.custom(settings.fontArabic, size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize))
                    .foregroundColor(settings.colorAccent.color)
                Text(numberData.transliteration)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(numberData.number)
                .font(.title2)
                .foregroundColor(settings.colorAccent.color)
        }
    }
}

struct ArabicView: View {
    @EnvironmentObject var settings: Settings
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    if searchText.isEmpty {
                        if !settings.favoriteLetters.isEmpty  {
                            Section(header: Text("FAVORITE LETTERS")) {
                                ForEach(settings.favoriteLetters.sorted(), id: \.id) { favorite in
                                    ArabicLetterRow(letterData: favorite)
                                }
                            }
                        }
                        
                        Section(header: Text("STANDARD ARABIC LETTERS")) {
                            ForEach(standardArabicLetters, id: \.letter) { letterData in
                                ArabicLetterRow(letterData: letterData)
                            }
                        }
                        
                        Section(header: Text("SPECIAL ARABIC LETTERS")) {
                            ForEach(otherArabicLetters, id: \.letter) { letterData in
                                ArabicLetterRow(letterData: letterData)
                            }
                        }
                        
                        Section(header: Text("ARABIC NUMBERS")) {
                            ForEach(numbers, id: \.number) { numberData in
                                ArabicNumberRow(numberData: numberData)
                            }
                        }
                        
                        Section(header: Text("QURAN SIGNS")) {
                            HStack {
                                Text("Make Sujood (Prostration)")
                                    .font(.subheadline)
                                Spacer()
                                Text("۩")
                                    .font(.subheadline)
                                    .foregroundColor(settings.colorAccent.color)
                            }
                            
                            HStack {
                                Text("The Mandatory Stop")
                                    .font(.subheadline)
                                Spacer()
                                Text("مـ")
                                    .font(.subheadline)
                                    .foregroundColor(settings.colorAccent.color)
                            }

                            HStack {
                                Text("The Preferred Stop")
                                    .font(.subheadline)
                                Spacer()
                                Text("قلى")
                                    .font(.subheadline)
                                    .foregroundColor(settings.colorAccent.color)
                            }

                            HStack {
                                Text("The Permissible Stop")
                                    .font(.subheadline)
                                Spacer()
                                Text("ج")
                                    .font(.subheadline)
                                    .foregroundColor(settings.colorAccent.color)
                            }

                            HStack {
                                Text("The Short Pause")
                                    .font(.subheadline)
                                Spacer()
                                Text("س")
                                    .font(.subheadline)
                                    .foregroundColor(settings.colorAccent.color)
                            }

                            HStack {
                                Text("Stop at One")
                                    .font(.subheadline)
                                Spacer()
                                Text("∴ ∴")
                                    .font(.subheadline)
                                    .foregroundColor(settings.colorAccent.color)
                            }

                            HStack {
                                Text("The Preferred Continuation")
                                    .font(.subheadline)
                                Spacer()
                                Text("صلى")
                                    .font(.subheadline)
                                    .foregroundColor(settings.colorAccent.color)
                            }

                            HStack {
                                Text("The Mandatory Continuation")
                                    .font(.subheadline)
                                Spacer()
                                Text("لا")
                                    .font(.subheadline)
                                    .foregroundColor(settings.colorAccent.color)
                            }
                            
                            if let url = URL(string: "https://studioarabiya.com/blog/tajweed-rules-stopping-pausing-signs/") {
                                Link("View More: Tajweed Rules & Stopping/Pausing Signs", destination: url)
                            }
                        }
                    } else {
                        Section(header: Text("SEARCH RESULTS")) {
                            ForEach(standardArabicLetters.filter { letterData in
                                let searchTextLowercased = searchText.lowercased()
                                
                                return searchTextLowercased.isEmpty ||
                                letterData.letter.lowercased().contains(searchTextLowercased) ||
                                letterData.name.lowercased().contains(searchTextLowercased) ||
                                letterData.transliteration.lowercased().contains(searchTextLowercased)
                            }) { letterData in
                                ArabicLetterRow(letterData: letterData)
                            }
                            
                            ForEach(otherArabicLetters.filter { letterData in
                                let searchTextLowercased = searchText.lowercased()
                                
                                return searchTextLowercased.isEmpty ||
                                letterData.letter.lowercased().contains(searchTextLowercased) ||
                                letterData.name.lowercased().contains(searchTextLowercased) ||
                                letterData.transliteration.lowercased().contains(searchTextLowercased)
                            }) { letterData in
                                ArabicLetterRow(letterData: letterData)
                            }
                        }
                    }
                }
                #if os(watchOS)
                .searchable(text: $searchText)
                #else
                .applyConditionalListStyle(defaultView: true)
                .dismissKeyboardOnScroll()
                #endif
                
                #if !os(watchOS)
                SearchBar(text: $searchText.animation(.easeInOut))
                    .padding(.horizontal, 8)
                #endif
            }
            .navigationTitle("Arabic Alphabet")
            .navigationBarTitleDisplayMode(.inline)
        }
   }
}

struct ArabicLetterView: View {
    @EnvironmentObject var settings: Settings
    
    let letterData: LetterData
        
    var body: some View {
        List {
            Section(header: LetterSectionHeader(letterData: letterData)) {
                VStack {
                    HStack(alignment: .center) {
                        Spacer()
                        
                        Text(letterData.transliteration)
                            .font(.subheadline)
                        
                        Spacer()
                        
                        Text(letterData.name)
                            .font(.custom(settings.fontArabic, size: UIFont.preferredFont(forTextStyle: .title1).pointSize))
                        
                        Spacer()
                    }
                }
            }
            
            Section(header: Text("DIFFERENT FORMS")) {
                VStack {
                    HStack(alignment: .center) {
                        ForEach(0..<3, id: \.self) { index in
                            Spacer()
                            
                            Text(letterData.forms[index])
                                .font(.custom(settings.fontArabic, size: UIFont.preferredFont(forTextStyle: .title1).pointSize))
                            
                            Spacer()
                        }
                    }
                }
            }
            
            if letterData.showTashkeel {
                Section(header: Text("DIFFERENT HARAKAAT (VOWELS)")) {
                    let chunks = tashkeels.chunked(into: 3)
                    ForEach(0..<chunks.count, id: \.self) { index in
                        VStack {
                            
                            TashkeelRow(
                                letterData: letterData,
                                tashkeels: chunks[index]
                            )
                            .padding(.top, 14)
                        }
                    }
                }
            }
            
            if (!letterData.showTashkeel && letterData.transliteration != "alif") || letterData.transliteration == "yaa" {
                Section(header: Text("PURPOSE")) {
                    if letterData.transliteration == "yaa" {
                        Text("In the Uthmani script of the Quran, when yaa is written at the end of the word, it is generally not written with two dots underneath.")
                            .font(.body)
                    } else if letterData.transliteration == "taa marbuuTa" {
                        Text("The letter \"taa marbuuTa\" translates to \"tied taa\", and it has a significant role in Arabic.")
                            .font(.body)
                        
                        Text("The purpose of taa marbuuTa is to indicate feminine gender in Arabic words. It is usually used at the end of a noun to signify that the noun is feminine. For example, the Arabic word for teacher is \"معلم\" (mu'allim) for a male and \"معلمة\" (mu'allima) for a female.")
                            .font(.body)
                        
                        Text("While taa marbuuTa is pronounced as a \"t\" sound when a word is in the construct state or when a pronoun is suffixed, it is usually silent at the end of words in pronunciation, but it affects the vowels before it. It usually creates a short \"ah\" sound, similar to ha/ه (like in \"mu'allimah\").")
                            .font(.body)
                    } else if letterData.transliteration == "hamzatul waSl" {
                        Text("The term \"hamzatul waSl\" translates to \"connecting hamza\" or \"hamza of connection.\"")
                            .font(.body)
                        
                        Text("This type of Hamza is always written as an Alif (ا) and only pronounced when it's at the beginning of a word that is being pronounced from the beginning. If the word comes after another word in a sentence (i.e., it's not at the beginning of the speech utterance), you don't pronounce the hamzatul waSl. You continue from the last letter of the previous word to the first letter (after the hamzatul waSl) of the next word. This gives a smooth connection between words, hence the name \"hamza of connection.\"")
                            .font(.body)
                        
                        Text("If a word starts with the hamzatul waSl, then it is pronounced as a hamza on an alif with either damma or kasra (no fatha). To determine which vowel mark to use, look at the third letter of the word, and if it has a damma, then pronounce it as a damma (أُ), but if it is a kasra or fatha, then pronounce it as a kasra (إِ). This ruling applies only for verbs.")
                            .font(.body)
                        
                        Text("There are only 7 nouns in the Quran that start with a hamzatul waSl, and unless you are connecting the words, you will always start the noun with a kasra regardless of the third letter of the word.")
                            .font(.body)
                        
                        Text("Generally, hamzatul waSl is usually not written with any diacritics, but in texts intended for learners or in the Quran, it can be indicated with the ص letter that stands for waSl above the Alif.")
                            .font(.body)
                    } else if letterData.transliteration.contains("hamza") {
                        Text("The letter hamza has several forms, which can seem a bit complicated. It can be written on its own, or on top of or below certain letters (\"alif\", \"waw\", or \"yaa\"). The form it takes often depends on the surrounding letters or the vowel/diacretic marks (tashkeel), which determine the sound of the word. Here are the different forms:")
                            .font(.body)
                        
                        Text("Hamza on its own (ء): When Hamza comes in the middle or at the end of a word, and it is not preceded by a vowel, it usually takes this form.")
                            .font(.body)
                        
                        Text("Hamza on an alif (أ or إ): When Hamza comes at the beginning of a word, it usually takes this form. When the vowel before it is \"fatha\" or \"damma\", it is written on top of an Alif (أ). When the vowel before it is \"kasra\", it is written below an Alif (إ).")
                            .font(.body)
                        
                        Text("Hamza on a waw (ؤ): When a word has Hamza following a \"damma\" vowel or \"waw\", it is written on top of a Waw (like this: ؤ).")
                            .font(.body)
                        
                        Text("Hamza on a yaa (ئ): When a word has Hamza following a \"kasra\" vowel or \"yaa\", it is written on top of a Ya'a (like this: ئ).")
                            .font(.body)
                        
                        Text("While the different forms of Hamza may look different, they all represent the same sound (ah/a). The forms are primarily a matter of Arabic orthography (spelling conventions) rather than phonetics (sound system).")
                            .font(.body)
                    } else if letterData.transliteration.contains("mad") {
                        Text("The squiggly line on top of the vowel letter is called a mad, which elongates the vowel sound longer than the vowel letter on its own with it lasting 4 counts. When an alif mad is succeeded by a letter with a shaddah, the mad is elongated for 6 counts instead of the normal 4.")
                            .font(.body)
                    } else if letterData.transliteration == "alif maqSoorah" {
                        Text("Alif maqSoorah is the same as an alif, but in a different form, similar to yaa and most of the times, it replaces a normal alif as the last letter of a word. There are some exceptions, like foreign words that are translated to Arabic (like non-Arab country names) and some words used in the Quran.")
                            .font(.body)
                    } else if letterData.transliteration == "laa" {
                        Text("The combination of ل and ا form a unique shape: لا.")
                            .font(.body)
                    }
                }
            }
        }
        #if !os(watchOS)
        .applyConditionalListStyle(defaultView: true)
        .dismissKeyboardOnScroll()
        #endif
        .navigationTitle(letterData.letter)
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

struct TashkeelRow: View {
    @EnvironmentObject var settings: Settings
    
    let letterData: LetterData
    let tashkeels: [Tashkeel]

    var body: some View {
        HStack(spacing: 20) {
            ForEach(tashkeels, id: \.english) { tashkeel in
                VStack(alignment: .center) {
                    if !tashkeel.transliteration.isEmpty {
                        Text(letterData.sound + tashkeel.transliteration)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    } else if tashkeel.english == "Shaddah" {
                        Text(letterData.sound + letterData.sound)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    } else if tashkeel.english == "Sukoon" {
                        Text(letterData.sound)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Text(letterData.letter + tashkeel.tashkeelMark)
                        .font(.custom(settings.fontArabic, size: UIFont.preferredFont(forTextStyle: .title1).pointSize))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    #if !os(watchOS)
                    Text(tashkeel.english)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    #endif
                }
            }
        }
    }
}
