import Foundation

struct ViewEntry: Identifiable, Codable, Equatable {
    let id: UUID
    var createdAt: Date
    var spotName: String
    var kind: String
    var notes: String

    init(id: UUID = UUID(), createdAt: Date = Date(), spotName: String = "", kind: String = "", notes: String = "") {
        self.id = id
        self.createdAt = createdAt
        self.spotName = spotName
        self.kind = kind
        self.notes = notes
    }
}
