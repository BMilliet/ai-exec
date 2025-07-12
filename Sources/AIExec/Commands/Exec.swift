import ArgumentParser

extension Runner {
    struct Exec: ParsableCommand {
        static let configuration = CommandConfiguration(abstract: "Execute changes from aggregated data.")

        @Flag(name: .shortAndLong, help: "Verbose mode.")
        var verbose = false

        func run() throws {
            let ui = UIImpl(verbose: verbose)
            ExecController(ui: ui).start()
        }
    }
}
