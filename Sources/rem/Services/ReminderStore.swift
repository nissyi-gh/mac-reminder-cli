import EventKit

actor ReminderStore {
    private let store = EKEventStore()

    func requestAccess() async throws {
        let granted = try await store.requestFullAccessToReminders()
        if !granted {
            throw ReminderError.accessDenied
        }
    }

    func fetchIncompleteReminders() async throws -> [ReminderItem] {
        let predicate = store.predicateForReminders(in: nil)

        let items: [ReminderItem] = try await withCheckedThrowingContinuation { continuation in
            store.fetchReminders(matching: predicate) { result in
                let reminders = result ?? []
                let items =
                    reminders
                    .filter { !$0.isCompleted }
                    .map { ReminderItem(title: $0.title ?? "（無題）", isCompleted: $0.isCompleted) }
                continuation.resume(returning: items)
            }
        }

        return items
    }

    func addReminder(title: String) async throws {
        guard let calendar = store.defaultCalendarForNewReminders() else {
            throw ReminderError.noDefaultCalendar
        }

        let reminder = EKReminder(eventStore: store)
        reminder.title = title
        reminder.calendar = calendar

        do {
            try store.save(reminder, commit: true)
        } catch {
            throw ReminderError.saveFailed(error.localizedDescription)
        }

    }
}
