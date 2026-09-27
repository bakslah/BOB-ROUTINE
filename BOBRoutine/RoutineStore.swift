import Foundation
import UserNotifications

@MainActor
final class RoutineStore: ObservableObject {
    @Published var isAwake = false
    @Published var water = 0
    @Published var completed: Set<String> = []

    let missions = ["Meal 1","Move 10 min","Meal 2","Workout","Wind-down"]

    func startDay() {
        isAwake = true
        completed.removeAll()
        water = 0
    }

    func toggle(_ item: String) {
        if completed.contains(item) { completed.remove(item) } else { completed.insert(item) }
    }

    func requestNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { _,_ in }
    }
}
