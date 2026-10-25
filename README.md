# ATLAS Knowledge Base

Shared ATLAS notes for the team and AI agents, starting with the multi-drone
simulation: two ArduCopter SITLs in one Gazebo world, separate MAVROS
namespaces, and inter-drone messaging.

The site is built with [Zensical](https://zensical.org/) and published with
GitHub Pages at:

**<https://aerotec-atlas.github.io/knowledge_base/>**

The repository is public. Do not put credentials, personal data, or sensitive
operational information in it.

## Local preview

Requires Python 3.11+.

```bash
bash scripts/serve.sh     # creates .venv/ on first run; serves at http://127.0.0.1:8000/knowledge_base/
bash scripts/check.sh     # regenerates the AI index, runs a strict build
```

The strict build writes `site/`. Broken navigation entries, broken internal
links, and missing anchors fail the build. If `make` is installed, `make serve`,
`make build`, and `make check` are shortcuts.

## Deploy

1. In GitHub: **Settings → Pages → Build and deployment → Source: GitHub Actions**.
2. Push to `main`. The workflow in `.github/workflows/docs.yml` builds the site,
   checks the generated AI index, and deploys the `site/` artifact.

No `gh-pages` branch and no custom domain are required.

## Repository map

```text
.
├── mkdocs.yml                 # site config (read by Zensical)
├── requirements.txt           # pinned build toolchain
├── Makefile                   # install / serve / build / llms / check
├── AGENTS.md                  # rules for AI and coding agents
├── CONTRIBUTING.md            # how to add and review pages
├── docs/
│   ├── index.md               # home
│   ├── using-the-knowledge-base.md
│   ├── team-memory.md
│   ├── control-mission-planning/
│   │   ├── index.md           # area landing page
│   │   └── multi-drone.md     # multi-drone simulation
│   ├── aerodynamics/          # empty area placeholders
│   ├── structures/
│   ├── systems-electronics/
│   ├── software-ai/
│   ├── media-communication/
│   ├── outreach-logistics/
│   ├── team-operations/
│   ├── llms.txt               # generated compact index for AI agents
│   └── llms-full.txt          # generated full text for AI agents
├── scripts/
│   ├── check.sh               # generate AI index + strict build
│   ├── serve.sh               # local preview
│   └── gen_llms_txt.py        # regenerates the two llms files
└── .github/workflows/docs.yml # build + deploy
```

The multi-drone page is seeded from `atlas_ws` at commit `e249b7e` and stays
`draft` until someone re-runs the commands in the current container. The area
landing pages other than Control & Mission Planning are intentionally empty
until there is content to put in them.

## AI-readable output

Two files are generated from the navigation and page frontmatter:

- [`docs/llms.txt`](docs/llms.txt) — compact index with one line per page.
- [`docs/llms-full.txt`](docs/llms-full.txt) — full text concatenation.

Regenerate them with `.venv/bin/python scripts/gen_llms_txt.py` (or `make llms`).
CI runs `python scripts/gen_llms_txt.py --check` and fails if they are out of
date. See [`AGENTS.md`](AGENTS.md) for the rules an AI agent should follow when
working in this repository.

## Contributing

Read [`CONTRIBUTING.md`](CONTRIBUTING.md). The short version: add a Markdown page
under `docs/`, add it to `nav` in `mkdocs.yml`, and run `bash scripts/check.sh`.
For how to read and add pages, see
[`docs/using-the-knowledge-base.md`](docs/using-the-knowledge-base.md).
For how the site works as team memory and AI context, see
[`docs/team-memory.md`](docs/team-memory.md).

## Toolchain note

The site uses **Zensical 0.0.72** and Python 3.11+. Zensical reads the existing
`mkdocs.yml`, so the configuration and page URLs stay compatible with MkDocs.
The previous MkDocs/Material build can be restored by reverting
`requirements.txt`, the emoji extension paths, and the build commands; no
Markdown content changes are needed.

## License

Content is © ATLAS. Add an explicit license before allowing reuse outside the
team.
