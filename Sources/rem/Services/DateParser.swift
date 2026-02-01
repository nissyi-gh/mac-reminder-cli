import Foundation

struct DateParser {
    static func parse(_ input: String) throws -> Date {
        // 相対時間のパース
        if let date = parseRelativeTime(input) {
            return date
        }

        // ISO形式のパース
        let formats = [
            "yyyy-MM-dd HH:mm",
            "yyyy-MM-dd'T'HH:mm",
            "yyyy-MM-dd"
        ]

        for format in formats {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            formatter.locale = Locale(identifier: "en_US_POSIX")

            if let date = formatter.date(from: input) {
                return date
            }
        }

        throw ReminderError.invalidDateFormat(input)
    }

    private static func parseRelativeTime(_ input: String) -> Date? {
        let pattern = #"^(\d+)(m|h|d|w)$"#
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(in: input, range: NSRange(input.startIndex..., in: input)),
              let valueRange = Range(match.range(at: 1), in: input),
              let unitRange = Range(match.range(at: 2), in: input),
              let value = Int(input[valueRange]) else {
            return nil
        }

        let unit = String(input[unitRange])
        let component: Calendar.Component
        switch unit {
        case "m": component = .minute
        case "h": component = .hour
        case "d": component = .day
        case "w": component = .weekOfYear
        default: return nil
        }

        return Calendar.current.date(byAdding: component, value: value, to: Date())
    }
}
