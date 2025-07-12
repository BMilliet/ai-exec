import ArgumentParser

struct Runner: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "ai-exec",
        abstract: "AIExec ✨ - Command-line tool for AI-driven code operations",
        version: "0.1.0",
        subcommands: [
            Aggregate.self,
            Exec.self
        ]
    )
}
