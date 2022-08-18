import Combine
import Foundation

class TimerManager: NSObject, ObservableObject {
    @Published var elapsedSeconds: Double = 0
    @Published var finalDuration: Double = 0
    @Published var elapsedSecondsFormatted: String = "0:00.00"

    var start: Date = Date()
    // Holds timer
    var cancellable: Cancellable?
    var accumulatedTime: Double = 0

    func setUpTimer() {
        start = Date()
        cancellable = Timer.publish(every: 0.01, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.elapsedSeconds = self.incrementElapsedTime()
                self.elapsedSecondsFormatted = self.getFormatedTime(seconds: self.elapsedSeconds)
            }
    }

    // Calculate the elapsed time.
    func incrementElapsedTime() -> Double {
        let runningTime: Double = -1 * (self.start.timeIntervalSinceNow)
        return self.accumulatedTime + runningTime
    }

    func endTimer() {
        // Cancel timer and set elapsedSeconds Publisher to 0
        cancellable?.cancel()
        finalDuration = elapsedSeconds
        elapsedSeconds = 0
    }

    // Creates spotwatch formatted version of time
    func getFormatedTime(seconds: Double) -> String {
        return self.elapsedTimeString(elapsed: self.secondsToHoursMinutesSeconds(seconds: seconds))
    }

    // Convert the seconds into seconds, minutes, hours.
    func secondsToHoursMinutesSeconds (seconds: Double) -> (Int16, Int16, Int16) {
        return ((Int16(seconds) % 3600) / 60, (Int16(seconds) % 3600) % 60, Int16(((seconds * 1000.0).truncatingRemainder(dividingBy: 1000)) / 10.0 ))
    }

    // Convert the seconds, minutes, hours into a string.
    func elapsedTimeString(elapsed: (m: Int16, s: Int16, ms: Int16)) -> String {
        return String(format: "%d:%02d.%02d", elapsed.m, elapsed.s, elapsed.ms)
    }
}
