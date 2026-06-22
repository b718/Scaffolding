require_relative 'back_end/ruby'
require_relative 'back_end/type_script'
require_relative 'front_end/init_front_end'
require_relative 'init_bun_workspace'
require_relative 'init_readme'

OPTIONS = %w[Ruby TypeScript].freeze

def prompt_selection
  puts 'Select a back-end language using numbers:'
  OPTIONS.each_with_index { |option, i| puts "  #{i + 1}) #{option}" }

  loop do
    print 'Enter selection: '
    choice = gets.chomp.strip.to_i
    return OPTIONS[choice - 1] if choice&.between?(1, OPTIONS.length)

    puts 'Invalid selection, try again.'
  end
end

def prompt_project_name
  print 'Please enter your project name: '
  project_name = gets.chomp.strip

  File.write('./scripts/project.txt', "PROJECT_NAME=#{project_name}\n")
end

prompt_project_name

case prompt_selection
when 'Ruby'
  Ruby.new.set_up_back_end
when 'TypeScript'
  init_bun_workspace
  TypeScript.new.set_up_back_end
end

init_front_end
init_readme
