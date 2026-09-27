import SwiftUI

@main
struct BOBRoutineApp: App {
    @StateObject private var store = RoutineStore()
    var body: some Scene {
        WindowGroup { ContentView().environmentObject(store) }
    }
}
