def main():
    front_end_path = "./front-end"
    update_claude_instructions(front_end_path)

def update_claude_instructions(front_end_path: str) -> None:
    content = (
        "## Styling\n"
        "\n"
        "- If components are needed, make a seperate folder for it called `components` at the root directory level.\n"
        "- If utilities are needed, make a seperate folder for it called `utilities` at the root directory level.\n"
        "- If a component has loading and/or error components, make a `useState` hook for each and create a display for the loading and error states.\n"
        "- If API calls are needed, create a `services/` folder at the root directory level. Split service files by domain (e.g. `auth.ts`, `player.ts`) — never put all calls in one file.\n"
        "- Always use `response` instead of `res` when naming API responses. \n"
    )
    with open(f"{front_end_path}/CLAUDE.md", "a") as f:
        f.write(content)

if __name__ == "__main__":
    main()
