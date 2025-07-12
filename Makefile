# Name of the binary
BINARY_NAME=ai-exec

# Path to the debug executable
BUILD_PATH=.build/debug/$(BINARY_NAME)

# Build the CLI
build:
	swift build -c debug
	@echo "✅ Build completed: $(BUILD_PATH)"

# Run the CLI with no arguments
run:
	swift run $(BINARY_NAME)

# Example: make run-aggregate
run-aggregate:
	swift run $(BINARY_NAME) aggregate

run-exec:
	swift run $(BINARY_NAME) exec

# Install to /usr/local/bin
install:
	cp $(BUILD_PATH) /usr/local/bin/$(BINARY_NAME)
	@echo "✅ Installed at /usr/local/bin/$(BINARY_NAME)"

# Clean build artifacts
clean:
	swift package clean
	@echo "🧹 Clean complete"

# Full rebuild
rebuild: clean build
