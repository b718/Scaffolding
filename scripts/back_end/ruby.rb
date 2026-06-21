require_relative 'programming_language'

class Ruby < ProgrammingLanguage
  def set_up_back_end
    write_justfile
    init_bundle
    init_gems
    init_tapioca
    lint_system
  end

  private

  def init_bundle
    system('bundle init', chdir: BACK_END_PATH)
  end

  def init_gems
    gems = 'sorbet tapioca rubocop roda sequel rerun puma rackup'
    system("bundle add #{gems}", chdir: BACK_END_PATH)
  end

  def init_tapioca
    system('bundle exec tapioca init', chdir: BACK_END_PATH)
  end

  def lint_system
    system('just lint', chdir: BACK_END_PATH)
  end

  def justfile_content
    <<~TEXT
      default:
          @just --list

      # Set-up local dev
      set-up-local-dev:
        @rerun -- rackup -p 3003

      # Lint the project using rubocop
      lint:
          @bundle exec rubocop -a

      # Update the RBIs
      rbi:
          @bundle install
          @bin/tapioca gems
    TEXT
  end
end
