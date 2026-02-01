import Testing

@testable import rem

@Test func アクセス拒否エラーのメッセージを確認() {
    let error = ReminderError.accessDenied

    #expect(error.errorDescription == "リマインダーへのアクセスが許可されていません")
}
@Test func デフォルトカレンダーなしエラーのメッセージを確認() {
    let error = ReminderError.noDefaultCalendar

    #expect(error.errorDescription == "デフォルトのリマインダーリストが見つかりません")
}
@Test func 保存失敗エラーに詳細メッセージが含まれる() {
    let error = ReminderError.saveFailed("ディスク容量不足")

    #expect(error.errorDescription == "リマインダーの保存に失敗しました: ディスク容量不足")
}
@Test func エラーはError型として扱える() {
    let error: any Error = ReminderError.accessDenied

    #expect(error is ReminderError)
}

@Test func 無効な日付形式エラーのメッセージを確認() {
    let error = ReminderError.invalidDateFormat("abc123")

    #expect(error.errorDescription == "無効な日付形式です: abc123")
}
