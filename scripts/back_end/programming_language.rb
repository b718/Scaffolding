require 'fileutils'

class ProgrammingLanguage
  BACK_END_PATH = './back-end'

  def set_up_back_end
    raise NotImplementedError
  end

  private

  def write_justfile
    Dir.mkdir(BACK_END_PATH) unless Dir.exist?(BACK_END_PATH)

    File.open("#{BACK_END_PATH}/justfile", 'w') do |file|
      file.puts(justfile_content)
    end
  end

  def justfile_content
    <<~TEXT
      default:
          @just --list

      # Set-up local dev
      set-up-local-dev:
          @bun run dev
    TEXT
  end

  def change_to_back_end_directory
    system("cd #{BACK_END_PATH}")
  end
end
