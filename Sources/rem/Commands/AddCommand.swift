import ArgumentParser

struct AddCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "add",
        abstract: "リマインダーを追加"
    )

    @Argument(help: "リマインダーのタイトル")
    var title: String

    func run() async throws {
        let store = ReminderStore()

        try await store.requestAccess()
        try await store.addReminder(title: title)

        print("追加しました: \(title)")
    }
}
