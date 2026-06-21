def init_readme
  project_name = File.read('./scripts/project.txt').strip.split('PROJECT_NAME=').last

  local_dev = <<~TEXT.chomp
    ### Local Development

    To get this running locally do the following.

    1. Make sure you have Docker desktop installed.
    2. Make sure you have mprocs installed.
    3. To start both the front and back end(s), type `mprocs` in the terminal.
  TEXT

  sections = [
    "## #{project_name.capitalize}",
    '## Demo Video',
    '## Architecture',
    '## Tech Stack',
    '### Front-End',
    '### Back-End',
    '### Database',
    local_dev
  ]

  File.write('./README.md', sections.join("\n\n") + "\n")

  puts "README.md initialized for '#{project_name}'"
end
