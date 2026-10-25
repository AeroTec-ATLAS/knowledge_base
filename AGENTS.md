# AGENTS.md

Rules for AI coding agents and anyone automating changes in this repository.
Humans should read [`CONTRIBUTING.md`](CONTRIBUTING.md) first.

## What this repository is

This is the ATLAS knowledge base: Markdown pages under `docs/`, built into a
static site with Zensical. It is **not** the flight-code repository. Code,
launch files, and scripts live in `atlas_ws` (a separate, private team
repository).

## Read order

1. `README.md` — repository layout and commands.
2. `mkdocs.yml` — navigation and build configuration.
3. `docs/index.md` — the entry point.
4. `docs/control-mission-planning/multi-drone.md` — the current substantive page.
5. The source files that the page references.

## Source-of-truth rules

- **Code wins.** If a page disagrees with `atlas_ws`, verify against the code and
  fix the page. Do not guess.
- **Do not invent commands, flags, topics, ports, or parameters.** If you cannot
  find it in the code or in a page that was verified against the code, say so.
- **Do not copy large code blocks.** Link to the source file and explain the
  behaviour. Small snippets are fine when they are the point of the page.
- **Do not mark a page `verified` without running the commands.** Use `draft`
  when you are documenting from source code or an older report.
- **Say what was not tested.** A short "not verified in the current container"
  note is better than a false claim.
- **Do not publish secrets.** No credentials, tokens, personal data, IP
  addresses, or sensitive operational details.

## Where content goes

| Topic | Location |
|---|---|
| Multi-drone simulation | `docs/control-mission-planning/multi-drone.md` |
| Area landing page | `docs/<area>/index.md` |
| How to use the site | `docs/using-the-knowledge-base.md` |
| Team memory and AI context | `docs/team-memory.md` |
| Any new topic | A new Markdown page under `docs/`, added to `nav` |

Keep the site small. Empty area landing pages are allowed; do not fill them with
placeholder prose just to make them look complete.

## Adding or editing a page

See `docs/using-the-knowledge-base.md` for the page workflow and
`docs/team-memory.md` for how the site is used as shared memory and AI context.

1. Write the page under `docs/`.
2. Add required frontmatter: `title`, `description`, `owner`, `status`,
   `last_reviewed`.
3. Add the page to `nav` in `mkdocs.yml`.
4. Link it from `docs/index.md` if it is a starting point.
5. Run the checks:

```bash
bash scripts/check.sh
```

`scripts/check.sh` creates `.venv/` on first run, regenerates `docs/llms.txt`
and `docs/llms-full.txt`, then runs `zensical build --strict`. The build fails on
broken navigation entries, broken internal links, and missing anchors. If `make`
is available, `make check` is a shortcut.

## Style

- One concept per page. Split pages that grow past a few screens.
- Use fenced code blocks with the shell language for commands.
- Say where a command runs: host, container, or SITL console.
- Use tables for symptom → cause → fix.
- Use Mermaid for flows and architecture when it is clearer than prose.
- Use `!!! warning`, `!!! note`, and `!!! tip` sparingly and for real caveats.
- Prefer explicit nouns and present tense. Avoid ambiguous "it" and "this".
- Keep line lengths reasonable; do not hard-wrap prose in the middle of a
  sentence just to fit a column.

## Frontmatter reference

```yaml
---
title: Page title
description: One sentence for search and the AI index.
owner: Control & Mission Planning
status: draft          # draft | verified | stale | deprecated
last_reviewed: 2026-10-25
applies_to: atlas_ws@e249b7e
tags: [simulation, mavros]
---
```

## Do not

- Do not add a page without adding it to `nav`.
- Do not add external link checkers or heavy plugins without discussing the
  maintenance cost first.
- Do not rewrite an entire area to "clean it up" in one pull request.
- Do not commit `site/`, `.venv/`, caches, or generated editor files.
- Do not change `site_url`, `repo_url`, or the Pages workflow without checking
  the deployment target.
