import SwiftUI

struct OtherView: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: ArabicView()) {
                        Label(
                            title: { Text("Arabic Alphabet") },
                            icon: { Image(systemName: "textformat.size.ar") }
                        )
                        .padding(.vertical, 4)
                    }
                }
                
                Section {
                    NavigationLink(destination: AdhkarView()) {
                        Label(
                            title: { Text("Common Adhkar") },
                            icon: { Image(systemName: "book.closed") }
                        )
                        .padding(.vertical, 4)
                    }
                }
                
                Section {
                    NavigationLink(destination: DuaView()) {
                        Label(
                            title: { Text("Common Duas") },
                            icon: { Image(systemName: "text.book.closed") }
                        )
                        .padding(.vertical, 4)
                    }
                }
                
                Section {
                    NavigationLink(destination: TasbihView()) {
                        Label(
                            title: { Text("Tasbih Counter") },
                            icon: { Image(systemName: "circles.hexagonpath.fill") }
                        )
                        .padding(.vertical, 4)
                    }
                }
                
                Section {
                    NavigationLink(destination: NamesView()) {
                        Label(
                            title: { Text("99 Names of Allah") },
                            icon: { Image(systemName: "signature") }
                        )
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Islamic Resources")
        }
    }
}
