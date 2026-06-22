require 'json'
require_relative 'back_end/programming_language'

def init_bun_workspace
  print 'Please enter your project name: '
  project_name = gets.chomp.strip

  File.write('./scripts/project.txt', "PROJECT_NAME=#{ProgrammingLanguage::BACK_END_PATH}\n")

  system('bun init --yes')
  system('rm -rf tsconfig.json CLAUDE.md .cursor')

  package_content = JSON.parse(File.read('package.json'))
  package_content['scripts'] = {
    'format' => 'prettier --write "**/*.{ts,tsx,js,mjs}" --ignore-path .prettierignore'
  }
  package_content['type'] = 'module'
  package_content['workspaces'] = ['front-end', 'back-end', 'packages/*']
  package_content['name'] = project_name

  File.write('package.json', JSON.pretty_generate(package_content))

  system('bun install @trivago/prettier-plugin-sort-imports prettier')
end
