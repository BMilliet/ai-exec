import ArgumentParser

extension Runner {
    struct Aggregate: ParsableCommand {
        static let configuration = CommandConfiguration(abstract: "Aggregate structured AI output.")
        
        @Flag(name: .shortAndLong, help: "Verbose mode.")
        var verbose = false
        
        func run() throws {
            let ui = UIImpl(verbose: verbose)
            AggregateController(ui: ui).start()
        }
    }
}
