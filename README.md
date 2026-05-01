### Purpose

Whenever I want to build a new project, I always spent a bit of time setting up my local development environment, but I've always viewed that time taken as wasteful, so I wanted to create a repository detailing my project set-up to speed up this process for myself.

### What gets created

- **front-end** — React/Next.js app
- **back-end** — Bun/Node app
- **infra/aws** — AWS CDK app (TypeScript)
- **packages/** — shared internal packages (add via `just create-package`)

### Prerequisites

- [Bun](https://bun.sh)
- [just](https://github.com/casey/just)
- [AWS CDK](https://docs.aws.amazon.com/cdk/latest/guide/cli.html) (`npm install -g aws-cdk`)

### Usage

```bash
git clone https://github.com/b718/set-up.git .
just set-up
```

You will be prompted to enter a project name. Once done, a fresh git repo is initialised and you're ready to go.

To add a shared package to `front-end` and `back-end`:

```bash
just create-package
```
