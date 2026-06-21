require 'json'
require_relative 'programming_language'

class TypeScript < ProgrammingLanguage
  def set_up_back_end
    write_justfile
    init_bun_project
    init_package_json
    update_claude_instructions
    setup_linter
  end

  private

  def init_bun_project
    Dir.mkdir(BACK_END_PATH) unless Dir.exist?(BACK_END_PATH)

    system('bun init . --yes', chdir: BACK_END_PATH)
  end

  def init_package_json
    package_json_path = "#{BACK_END_PATH}/package.json"
    package_content = JSON.parse(File.read(package_json_path))
    package_content['scripts'] = { 'dev' => 'bun --bun --hot index.ts' }
    File.write(package_json_path, JSON.pretty_generate(package_content))
  end

  def update_claude_instructions
    content = <<~TEXT
      ## Styling

      - For logging, always use `pino`.
      - When creating try-catches, always use `err` as the variable name for the error.
      - Always use `response` instead of `res` when naming API responses.
    TEXT

    File.open("#{BACK_END_PATH}/CLAUDE.md", 'a') { |f| f.write(content) }
  end

  def setup_linter
    system('@bun install @trivago/prettier-plugin-sort-imports prettier')
  end
end
