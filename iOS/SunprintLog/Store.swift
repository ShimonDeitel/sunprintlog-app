import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var entries: [ViewEntry] = []
    @Published var isProUnlocked: Bool = false

    /// Free tier keeps every seeded entry visible without hitting the paywall on first launch.
    static let freeTierLimit = 20

    private let fileURL: URL

    init() {
        let appSupport = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        let dir = appSupport.appendingPathComponent("SunprintLog", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("entries.json")
        load()
    }

    var canAddMore: Bool {
        isProUnlocked || entries.count < Store.freeTierLimit
    }

    func add(_ entry: ViewEntry) {
        guard canAddMore else { return }
        entries.insert(entry, at: 0)
        save()
    }

    func update(_ entry: ViewEntry) {
        guard let idx = entries.firstIndex(where: { $0.id == entry.id }) else { return }
        entries[idx] = entry
        save()
    }

    func delete(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
        save()
    }

    func delete(_ entry: ViewEntry) {
        entries.removeAll { $0.id == entry.id }
        save()
    }

    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([ViewEntry].self, from: data) {
            entries = decoded
        } else {
            entries = Store.seedData()
            save()
        }
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(entries) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    static func seedData() -> [ViewEntry] {
        [
        ViewEntry(spotName: "View Log 1", kind: "View Log 1", notes: "View Log 1"),
        ViewEntry(spotName: "View Log 2", kind: "View Log 2", notes: "View Log 2"),
        ViewEntry(spotName: "View Log 3", kind: "View Log 3", notes: "View Log 3"),
        ViewEntry(spotName: "View Log 4", kind: "View Log 4", notes: "View Log 4")
        ]
    }
}
