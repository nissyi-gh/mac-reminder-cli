import ArgumentParser

struct ListCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "list",
        abstract: "リマインダー一覧を表示"
    )

    func run() async throws {
        let store = ReminderStore()

        try await store.requestAccess()
        let items = try await store.fetchIncompleteReminders()

        if items.isEmpty {
            print("未完了のリマインダーはありません")
        } else {
            for item in items {
                print("・ \(item.title)")
            }
        }
    }
}
