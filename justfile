default:
    @just --list

# Set-up my local machine
set-up:
    @python3 scripts/init_bun_workspace.py
    @bun create next-app@latest front-end --default
    @bun init back-end --yes
    @mkdir infra
    @mkdir infra/aws
    @cd infra/aws && cdk init app --language=typescript
    @find . -type d -name ".git" -exec rm -rf {} +
    @bun install @trivago/prettier-plugin-sort-imports prettier
    @rm README.md
    @git init

# Create a new Bun package
create-package:
    @cd scripts && python3 create_package.py