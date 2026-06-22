default:
    @just --list

# Set up project scaffolding on local machine
set-up-project:
    @ruby scripts/init_project.rb
    @mkdir -p infra/aws
    @cd infra/aws && cdk init app --language=typescript
    @find . -type d -name ".git" -exec rm -rf {} +
    @git init

# Create a new Bun package
create-package:
    @ruby ./scripts/create_package.rb

# Format Project
format:
    @bun run format