import ArgumentParser
import Foundation

struct AddCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "add",
        abstract: "リマインダーを追加"
    )

    @Argument(help: "リマインダーのタイトル")
    var title: String

    @Option(name: [.short, .long], help: "期限 (例: 2024-01-15, 1h, 30m, 3d, 1w)")
    var due: String?

    func run() async throws {
        let store = ReminderStore()

        try await store.requestAccess()

        let dueDate: Date? = if let due {
            try DateParser.parse(due)
        } else {
            nil
        }

        try await store.addReminder(title: title, dueDate: dueDate)

        var message = "追加しました: \(title)"
        if let dueDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            formatter.locale = Locale(identifier: "ja_JP")
            message += " (期限: \(formatter.string(from: dueDate)))"
        }
        print(message)
    }
}
