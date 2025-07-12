struct ChangeSet: Codable {
    var actions: [Action]
}

struct Action: Codable {
    var action: String
    var path: String
    var content: String?
    var edits: [Edit]?
}

struct Edit: Codable {
    var operation: String
    var search: String
    var content: String
}
