import Foundation

struct AggregateController {
    let ui: UI

    func start() {
        ui.message("Which type of file should aggregate?")
        guard let ext = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines), !ext.isEmpty else {
            ui.error("No file extension provided.")
            return
        }

        let currentDir = FileManager.default.currentDirectoryPath
        let filePaths = findFiles(withExtension: ext, in: currentDir)

        var buffer: [String] = []
        var fileCounter = 1
        var lineCounter = 0
        let maxLines = 10000

        for path in filePaths {
            let relativePath = path.replacingOccurrences(of: currentDir + "/", with: "")
            buffer.append("\n--- START \(relativePath) ---\n")
            if let content = try? String(contentsOfFile: path, encoding: .utf8) {
                buffer.append(content)
                lineCounter += content.components(separatedBy: "\n").count
            } else {
                buffer.append("[ERROR: Could not read file]")
            }
            buffer.append("\n--- END \(relativePath) ---\n")

            if lineCounter >= maxLines {
                writeAggregated(buffer, index: fileCounter)
                fileCounter += 1
                buffer.removeAll()
                lineCounter = 0
            }
        }

        if !buffer.isEmpty {
            writeAggregated(buffer, index: fileCounter)
        }

        ui.message("✅ Aggregation completed with \(fileCounter) file(s).")
    }

    private func findFiles(withExtension ext: String, in path: String) -> [String] {
        var files: [String] = []
        let fm = FileManager.default
        let enumerator = fm.enumerator(atPath: path)

        while let element = enumerator?.nextObject() as? String {
            if element.hasSuffix(".\(ext)") {
                files.append("\(path)/\(element)")
            }
        }
        return files
    }

    private func writeAggregated(_ lines: [String], index: Int) {
        let fileName = "aggregated_\(index).txt"
        let outputPath = FileManager.default.currentDirectoryPath + "/" + fileName
        let content = lines.joined(separator: "\n")
        try? content.write(toFile: outputPath, atomically: true, encoding: .utf8)
    }
}
