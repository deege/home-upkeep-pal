import Foundation

/// Simple in-memory activity logger. For MVP it just stores strings; later it could persist and sync.
public final class ActivityLogger {
    public private(set) var entries: [String] = []

    public init() {}

    public func log(_ message: String) {
        entries.append("\(Date()): \(message)")
    }
}
