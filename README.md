# Medera Docs Enterprise documentation for the Medera AI platform — multimodal sensing, text generation, agentic framework, medical coding, and the full API reference. Built with [Mintlify](https://mintlify.com). ## Pushing to GitHub (first-time setup) The repo is initialized locally and a commit is staged on `main`. Before pushing, remove the leftover lock file (it was held by a sandboxed session that couldn't release it), then push from your terminal where your GitHub auth lives: ```bash
cd ~/Documents/Docs/Docs
rm -f.git/index.lock # one-time cleanup if it exists
git add -A && git commit -m "chore: push docs" || true./push.sh # HTTPS (gh / PAT)
# or./push.sh ssh # SSH (git@github.com)
``` Then connect the repo in the [Mintlify dashboard](https://dashboard.mintlify.com) — Mintlify auto-deploys on every push to `main`. ## Local development Install the Mintlify CLI and run the dev server in this folder. ```bash
npm i -g mint
mint dev
``` The site is served at `http://localhost:3000`. ## Validating links and configuration ```bash
mint broken-links
mint config:check
``` ## Structure ```.
├── docs.json # Mintlify navigation + theme config
├── favicon.svg # Site favicon
├── logo/ # Light + dark logo SVGs
├── get-started/ # Welcome, console, and per-product guides
├── about/ # Introduction, compliance, languages, roadmap
├── quickstart/ # 7 quickstart guides
├── authentication/ # OAuth 2.0 + session JWT
├── multimodal/ # STT, facial, vocal, Neurobehavioral Construct
├── textgen/ # Documents, templates, FactsR, RAG
├── agentic/ # Framework, 24 agents, experts, canvas
├── coding/ # ICD-10, CPT, HCPCS, SNOMED, LOINC, RxNorm
├── compliance/ # HIPAA, 42 CFR Part 2, RLS, encryption
├── sdks/ # JavaScript, Python, web components, CLI
├── api-reference/ # Full REST + WebSocket API reference
└── release-notes/ # Per-product release notes
``` ## Editing Pages are written in MDX. Mintlify components used throughout: - `<Card>`, `<CardGroup>`, `<Columns>` for product cards
- `<Steps>` for sequenced guides
- `<Tip>`, `<Note>`, `<Warning>`, `<Info>` for callouts
- `<Icon>` for inline icons (Lucide / Font Awesome) ## Deploying Deployments are managed in the Mintlify dashboard, connected to this GitHub repository. Pushes to `main` trigger automatic deploys. ## Conventions - Filenames are kebab-case (`patient-intake.mdx`)
- Frontmatter always includes `title` and `description`
- Internal links use absolute paths (`/agentic/overview`) — never relative
- External links open in a new tab via `target="_blank"` where appropriate
- Code examples target the latest stable SDK and API versions ## License (c) 2026 Medera Inc. All rights reserved. The documentation in this repository is provided for use by Medera customers, partners, and developers.