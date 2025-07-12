import Foundation

struct ExecController {
    let ui: UI

    func start() {
        let path = FileManager.default.currentDirectoryPath + "/ai_changes.json"

        guard let data = FileManager.default.contents(atPath: path) else {
            ui.error("Could not find ai_changes.json in current directory")
            return
        }

        guard let json = try? JSONDecoder().decode(ChangeSet.self, from: data) else {
            ui.error("Failed to decode JSON structure")
            return
        }

        for action in json.actions {
            switch action.action {
            case "create_file":
                try? FileManager.default.createDirectory(atPath: (action.path as NSString).deletingLastPathComponent, withIntermediateDirectories: true)
                try? action.content?.write(toFile: action.path, atomically: true, encoding: .utf8)
                ui.message("✅ Created file: \(action.path)")

            case "delete_file":
                try? FileManager.default.removeItem(atPath: action.path)
                ui.message("🗑️ Deleted file: \(action.path)")

            case "edit_file":
                guard let content = action.content else {
                    ui.error("⚠️ Skipping edit_file: missing 'content' field for \(action.path)")
                    continue
                }
                try? content.write(toFile: action.path, atomically: true, encoding: .utf8)
                ui.message("✏️ Rewrote file: \(action.path)")

            default:
                ui.error("Unknown action: \(action.action)")
            }
        }

        ui.message("✅ Execution completed")
    }
}
