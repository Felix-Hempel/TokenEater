import Testing
import Foundation

@Suite("NotificationService pacing keys")
struct NotificationServicePacingTests {

    @Test("pacing keys name the window so weekly and session read distinctly")
    func keysAreWindowSpecific() {
        let weekly = NotificationService.pacingNotificationKeys(zone: .hot, window: "weekly")
        let session = NotificationService.pacingNotificationKeys(zone: .hot, window: "fivehour")

        #expect(weekly.title == "notif.title.pacing.hot.weekly")
        #expect(weekly.body == "notif.body.pacing.hot.weekly")
        #expect(session.title == "notif.title.pacing.hot.fivehour")
        #expect(session.body == "notif.body.pacing.hot.fivehour")
    }

    @Test("weekly and session pacing alerts use distinct dedupe ids")
    func idsDoNotCollideAcrossWindows() {
        let weekly = NotificationService.pacingNotificationKeys(zone: .hot, window: "weekly")
        let session = NotificationService.pacingNotificationKeys(zone: .hot, window: "fivehour")

        #expect(weekly.id != session.id)
        #expect(weekly.id == "pacing_weekly_hot")
        #expect(session.id == "pacing_fivehour_hot")
    }

    @Test("warning and hot produce different keys and ids for the same window")
    func zoneIsEncodedInKeys() {
        let warning = NotificationService.pacingNotificationKeys(zone: .warning, window: "weekly")
        let hot = NotificationService.pacingNotificationKeys(zone: .hot, window: "weekly")

        #expect(warning.title != hot.title)
        #expect(warning.id == "pacing_weekly_warning")
        #expect(hot.id == "pacing_weekly_hot")
    }
}
