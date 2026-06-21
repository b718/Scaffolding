FRONT_END_PATH = './front-end'.freeze

def init_front_end
  system('bun create next-app@latest front-end --default')
  update_claude_instructions
end

def update_claude_instructions
  content = <<~TEXT
    ## Styling

    - If components are needed, make a seperate folder for it called `components` at the root directory level.
    - If utilities are needed, make a seperate folder for it called `utilities` at the root directory level.
    - If a component has loading and/or error components, make a `useState` hook for each and create a display for the loading and error states.
    - If API calls are needed, create a `services/` folder at the root directory level. Split service files by domain (e.g. `auth.ts`, `player.ts`) — never put all calls in one file.
    - Always use `response` instead of `res` when naming API responses.
  TEXT

  File.open("#{FRONT_END_PATH}/CLAUDE.md", 'a') { |f| f.write(content) }
end
