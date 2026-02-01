import ArgumentParser

@main
struct Rem: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "rem",
        abstract: "macOS Reminders CLI",
        subcommands: [ListCommand.self, AddCommand.self]
    )
}
