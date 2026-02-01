import Testing
import Foundation

@testable import rem

@Test func ISO日付をパースできる() throws {
    let date = try DateParser.parse("2024-01-15")
    let components = Calendar.current.dateComponents([.year, .month, .day], from: date)

    #expect(components.year == 2024)
    #expect(components.month == 1)
    #expect(components.day == 15)
}

@Test func ISO日時をパースできる() throws {
    let date = try DateParser.parse("2024-01-15 14:30")
    let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)

    #expect(components.year == 2024)
    #expect(components.month == 1)
    #expect(components.day == 15)
    #expect(components.hour == 14)
    #expect(components.minute == 30)
}

@Test func ISO日時T区切りをパースできる() throws {
    let date = try DateParser.parse("2024-01-15T14:30")
    let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)

    #expect(components.year == 2024)
    #expect(components.month == 1)
    #expect(components.day == 15)
    #expect(components.hour == 14)
    #expect(components.minute == 30)
}

@Test func 相対時間_分をパースできる() throws {
    let before = Date()
    let date = try DateParser.parse("30m")
    let after = Date()

    let expectedMin = before.addingTimeInterval(30 * 60)
    let expectedMax = after.addingTimeInterval(30 * 60)

    #expect(date >= expectedMin && date <= expectedMax)
}

@Test func 相対時間_時間をパースできる() throws {
    let before = Date()
    let date = try DateParser.parse("2h")
    let after = Date()

    let expectedMin = before.addingTimeInterval(2 * 60 * 60)
    let expectedMax = after.addingTimeInterval(2 * 60 * 60)

    #expect(date >= expectedMin && date <= expectedMax)
}

@Test func 相対時間_日をパースできる() throws {
    let before = Date()
    let date = try DateParser.parse("3d")
    let after = Date()

    let expectedMin = before.addingTimeInterval(3 * 24 * 60 * 60)
    let expectedMax = after.addingTimeInterval(3 * 24 * 60 * 60)

    #expect(date >= expectedMin && date <= expectedMax)
}

@Test func 相対時間_週をパースできる() throws {
    let before = Date()
    let date = try DateParser.parse("1w")
    let after = Date()

    let expectedMin = before.addingTimeInterval(7 * 24 * 60 * 60)
    let expectedMax = after.addingTimeInterval(7 * 24 * 60 * 60)

    #expect(date >= expectedMin && date <= expectedMax)
}

@Test func 無効な形式でエラーを返す() {
    #expect(throws: ReminderError.self) {
        try DateParser.parse("invalid")
    }
}
