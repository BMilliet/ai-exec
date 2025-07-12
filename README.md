# AI-Exec 🧠✨

**AI-Exec** is a lightweight CLI tool that enables automated codebase editing using AI-generated JSON instructions.

It allows LLMs (like ChatGPT or Gemini) to analyze your codebase and respond with structured change instructions in JSON format, which `ai-exec` can then execute to:
- ✅ Create new files
- ✅ Overwrite existing files with new content
- ✅ Delete files

---

## 🛠 How It Works

1. **Aggregate** your project files using the `aggregate` command.
   This scans your project and creates a `aggregated_1.txt`, `aggregated_2.txt`, etc., bundling code files in a format easily digestible by AI.

2. **Prompt your AI** (e.g. ChatGPT) using the prompt template in [`ai_exec_prompt.md`](./ai_exec_prompt.md).  
   Provide a clear task and paste the aggregated file(s) as reference.

3. **Paste the resulting JSON** into a file named `ai_changes.json` in your project root.

4. **Run the executor**:
   ```bash
   ai-exec exec
   ```

---

## 📦 Commands

### `ai-exec aggregate`

Prompts the user for a file extension (e.g. `swift`, `kt`, `go`) and aggregates all matching files recursively from the current directory.  
It outputs 1 or more files like `aggregated_1.txt`, `aggregated_2.txt` in chunks of 1000 lines.

### `ai-exec exec`

Reads the `ai_changes.json` file in the current directory and applies all actions listed in it:
- `create_file`
- `edit_file` (overwrites entire file)
- `delete_file`

---

## 📂 JSON Instruction Format

Example:
```json
{
  "actions": [
    {
      "action": "create_file",
      "path": "Sources/App/NewFile.swift",
      "content": "print(\"Hello World\")"
    },
    {
      "action": "edit_file",
      "path": "Sources/App/OldFile.swift",
      "content": "// Entire new content of the file here"
    },
    {
      "action": "delete_file",
      "path": "Sources/App/Obsolete.swift"
    }
  ]
}
```

---

## 📑 Prompt Template

Use the instructions in [`ai_exec_prompt.md`](./ai_exec_prompt.md) to guide any LLM on how to generate the proper JSON based on your codebase and task.

---

## ⚠️ Warnings

- `ai-exec` will **overwrite files directly**. Ensure you have backups or version control.
- Only use AI-generated JSON that strictly follows the format and rules.

---

## ✅ Example Flow

```bash
ai-exec aggregate
# → select extension (e.g. swift)

# → go to ChatGPT and ask: "Add authentication controller"
# → paste aggregated_1.txt and prompt instructions
# → get JSON output and save as ai_changes.json

ai-exec exec
# → files are updated automatically ✨
```

