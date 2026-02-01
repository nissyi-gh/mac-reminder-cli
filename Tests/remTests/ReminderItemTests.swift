import Testing

@testable import rem

@Test func リマインダーアイテムを作成できる() {
    let item = ReminderItem(title: "買い物", isCompleted: false)

    #expect(item.title == "買い物")
    #expect(item.isCompleted == false)
}

@Test func 完了済みリマインダーを作成できる() {
    let item = ReminderItem(title: "掃除", isCompleted: true)

    #expect(item.title == "掃除")
    #expect(item.isCompleted == true)
}

@Test func 空のタイトルでも作成できる() {
    let item = ReminderItem(title: "", isCompleted: false)

    #expect(item.title == "")
    #expect(item.title.isEmpty)
}
