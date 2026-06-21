require 'json'

PROJECT_NAME = File.read('./scripts/project.txt').strip.split('PROJECT_NAME=').last.freeze

def main
  if PROJECT_NAME.empty?
    puts "Please initialize a value for the 'PROJECT_NAME' key."
    return
  end

  print 'Please enter package name: '
  package_name = gets.chomp.strip

  create_package(package_name)
  update_package_jsons(package_name)

  puts "Successfully created '#{package_name}' package!"
end

def create_package(package_name)
  package_path = "./packages/#{package_name}/src"

  system('mkdir', '-p', package_path)
  File.write("#{package_path}/#{package_name}.ts", '')

  package_json = {
    'name' => "@#{PROJECT_NAME}/#{package_name}",
    'version' => '1.0.0',
    'module' => "./src/#{package_name}.ts",
    'types' => "./src/#{package_name}.ts",
    'exports' => { '.' => "./src/#{package_name}.ts" }
  }

  File.write("#{package_path}/../package.json", JSON.pretty_generate(package_json))
end

def update_package_jsons(package_name)
  new_package = "@#{PROJECT_NAME}/#{package_name}"
  paths = ['./front-end/package.json', './back-end/package.json']

  paths.each do |path|
    package_content = JSON.parse(File.read(path))
    package_content['dependencies'] ||= {}
    package_content['dependencies'][new_package] = 'workspace:*'
    File.write(path, JSON.pretty_generate(package_content))
  end

  %w[./front-end ./back-end].each do |workspace|
    system('bun', 'install', chdir: workspace)
  end
end

main
