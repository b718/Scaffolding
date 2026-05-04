default:
    @just --list

# Set up project scaffolding on local machine
set-up-project:
    @python3 scripts/init_bun_workspace.py
    @bun create next-app@latest front-end --default
    @bun init back-end --yes
    @mkdir infra
    @mkdir infra/aws
    @cd infra/aws && cdk init app --language=typescript
    @find . -type d -name ".git" -exec rm -rf {} +
    @bun install @trivago/prettier-plugin-sort-imports prettier
    @python3 scripts/init_readme.py
    @python3 scripts/init_back_end.py
    @python3 scripts/init_front_end.py
    @git init

# Create a new Bun package
create-package:
    @python3 ./scripts/create_package.py

# Format Project
format:
    @bun run format