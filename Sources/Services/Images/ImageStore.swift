import Foundation
#if canImport(UIKit)
import UIKit
#endif

/// Simple image store for caching and retrieving images by file name.
public final class ImageStore {
    public init() {}

    public func save(image: Data, named: String) throws {
        let url = try storageURL(for: named)
        try image.write(to: url)
    }

    public func load(named: String) -> Data? {
        guard let url = try? storageURL(for: named) else { return nil }
        return try? Data(contentsOf: url)
    }

    // MARK: - Helpers
    private func storageURL(for name: String) throws -> URL {
        let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return dir.appendingPathComponent(name)
    }
}
