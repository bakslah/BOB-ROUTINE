import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: RoutineStore

    var body: some View {
        TabView {
            NavigationStack { TodayView() }
                .tabItem { Label("Hari Ini", systemImage: "house.fill") }
            NavigationStack { ProgressViewScreen() }
                .tabItem { Label("Progress", systemImage: "chart.line.uptrend.xyaxis") }
            NavigationStack { SettingsView() }
                .tabItem { Label("Saya", systemImage: "person.fill") }
        }
        .preferredColorScheme(.dark)
        .tint(.cyan)
        .onAppear { store.requestNotifications() }
    }
}

struct TodayView: View {
    @EnvironmentObject var store: RoutineStore
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Text("BOB Routine").font(.largeTitle.bold())
                Text("Sehat dulu. Konsisten, bukan sempurna.").foregroundStyle(.secondary)
                Button {
                    store.startDay()
                } label: {
                    Label(store.isAwake ? "Hari sudah dimulai" : "Aku Sudah Bangun ☀️", systemImage: "sun.max.fill")
                        .frame(maxWidth: .infinity).padding()
                }
                .buttonStyle(.borderedProminent)
                .disabled(store.isAwake)

                GroupBox("Misi Hari Ini") {
                    VStack(spacing: 12) {
                        ForEach(store.missions, id: \.self) { item in
                            Button { store.toggle(item) } label: {
                                HStack {
                                    Image(systemName: store.completed.contains(item) ? "checkmark.circle.fill" : "circle")
                                    Text(item)
                                    Spacer()
                                }
                            }.buttonStyle(.plain)
                        }
                    }.padding(.vertical, 6)
                }

                GroupBox("Air") {
                    HStack {
                        Text("\(store.water) / 8 gelas").font(.title3.bold())
                        Spacer()
                        Button("+ 1") { if store.water < 8 { store.water += 1 } }
                            .buttonStyle(.borderedProminent)
                    }
                }

                GroupBox("Workout") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Normal").bold()
                        Text("20–30 menit gerak ringan–sedang")
                        Divider()
                        Text("Mager Mode").bold()
                        Text("7 menit. Yang penting mulai.")
                    }
                }
            }.padding()
        }
        .navigationTitle("Hari Ini")
    }
}

struct ProgressViewScreen: View {
    var body: some View {
        List {
            Section("Progress") {
                Label("Berat badan", systemImage: "scalemass")
                Label("Lingkar pinggang", systemImage: "ruler")
                Label("Foto progress", systemImage: "photo")
            }
        }.navigationTitle("Progress")
    }
}

struct SettingsView: View {
    var body: some View {
        List {
            Section("BOB Routine") {
                Label("Adaptive Day aktif", systemImage: "clock.arrow.circlepath")
                Label("Data tersimpan di perangkat", systemImage: "iphone")
            }
        }.navigationTitle("Saya")
    }
}
