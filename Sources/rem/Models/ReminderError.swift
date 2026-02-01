import Foundation

enum ReminderError: Error, LocalizedError {
    case accessDenied
    case noDefaultCalendar
    case saveFailed(String)
    case invalidDateFormat(String)

    var errorDescription: String? {
        switch self {
        case .accessDenied:
            return "リマインダーへのアクセスが許可されていません"
        case .noDefaultCalendar:
            return "デフォルトのリマインダーリストが見つかりません"
        case .saveFailed(let message):
            return "リマインダーの保存に失敗しました: \(message)"
        case .invalidDateFormat(let input):
            return "無効な日付形式です: \(input)"
        }
    }
}
