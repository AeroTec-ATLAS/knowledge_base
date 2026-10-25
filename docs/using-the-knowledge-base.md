---
title: Using the knowledge base
description: How to read, search, and add pages to the ATLAS knowledge base.
owner: ATLAS
status: draft
last_reviewed: 2026-10-25
tags: [contributing, docs]
---

# Using the knowledge base

This site is the ATLAS knowledge base. It holds explanations, project notes,
mission records, and references. Pages are written so a person can read them
and an AI agent can use them as context.

For how the site works as shared team memory and AI context, see
[Team memory and AI wiki](team-memory.md).

## Read a page

- Use the left sidebar to move between areas and pages. The right sidebar lists
  the sections on the current page.
- Use search to find a term, command, or topic.
- Check the frontmatter before relying on a detail:
    - `status: draft` means the content is not fully verified.
    - `status: verified` means the commands or content were checked.
    - `status: stale` means the page may no longer match the code.
    - `status: deprecated` means the page is kept for history.
- Check `applies_to` for the commit or version the page was checked against.
- Follow the source links before copying a command or parameter.

## Add or edit a page

### 1. Choose the page type

| Type | Use it for | Suggested sections |
|---|---|---|
| Explanation | How something works, why a choice was made, or how the pieces fit together. | Context, How it works, Trade-offs, Source |
| Project | A new project, initiative, or workstream. | Goal, Scope, Owner, Status, Next steps, Links |
| Mission | A specific flight, test, demo, or simulation mission. | Objective, Setup, Procedure, Results, Open issues |
| How-to | A repeatable task with commands or steps. | Before you start, Steps, Verify, Troubleshoot |
| Reference | Commands, parameters, ports, or other lookup material. | Tables, Notes, Source |

If a page fits more than one type, pick the one that answers the reader's main
question and link to the others instead of duplicating content.

### 2. Create the file

Create a Markdown file under `docs/`:

```text
docs/new-project.md
docs/control-mission-planning/new-mission.md
```

Use lowercase words separated by hyphens. Start every page with frontmatter:

```yaml
---
title: Short page title
description: One sentence that explains what the page is for.
owner: Control & Mission Planning
status: draft
last_reviewed: 2026-10-25
applies_to: atlas_ws@<commit>   # optional
tags: [simulation, mavros]
---
```

Use `status: draft` until someone actually runs the commands or checks the
content. Do not mark a page `verified` from memory.

### 3. Add it to the navigation

Add the page to `nav` in `mkdocs.yml`:

```yaml
nav:
  - Home: index.md
  - Using the knowledge base: using-the-knowledge-base.md
  - Team memory and AI wiki: team-memory.md
  - Areas:
      - Control & Mission Planning:
          - control-mission-planning/index.md
          - Multi-drone: control-mission-planning/multi-drone.md
          - New mission: control-mission-planning/new-mission.md
```

A page that is not in `nav` is hard to find. If you create a new area, also add
an `index.md` for that area.

### 4. Link it from the home page or area index

Add a link from `docs/index.md` if the page is a starting point. Otherwise, link
it from the area index:

```markdown
- [New mission](control-mission-planning/new-mission.md)
```

Keep links relative to the page that contains them. If you move a page, update
the links that point to it.

### 5. Run the checks

```bash
bash scripts/check.sh
```

The script regenerates `docs/llms.txt` and `docs/llms-full.txt`, then runs a
strict Zensical build. Broken navigation entries, broken internal links, and
missing anchors fail the build.

Do not commit `site/` or `.venv/`.

## Appendix: How AI should create a page

An AI agent with the repository open can do the first draft, update `nav`, and
run the checks. Give it a prompt like this:

```text
Add a new <explanation | project | mission | how-to | reference> page to the ATLAS knowledge base.

Topic: <topic>
Owner: <owner>
Goal: <what the reader should understand or be able to do>
Sources: <atlas_ws paths, logs, links, or existing pages>
Status: draft

Follow AGENTS.md and docs/using-the-knowledge-base.md.

1. Choose the right page type and a short filename under docs/.
2. Create the page with complete frontmatter.
3. Add it to nav in mkdocs.yml and link it from docs/index.md or the relevant area index.
4. Run bash scripts/check.sh.
5. Report the files changed and anything you could not verify.

Do not invent commands, ports, parameters, or results. If a fact is missing from the sources, write "not verified" or leave a clear TODO. Do not mark the page verified.
```

The agent should read `AGENTS.md`, the pages named in the prompt, and the source
files before writing. Code wins over memory and older notes. Ask for a small
diff, not a rewrite of the site.

Review the result:

- Does the page answer the question from the prompt?
- Are commands, ports, parameters, and results backed by a source?
- Does the page say what was not tested?
- Is it in the right area and in `nav`?
- Does the home page or area index link to it?
- Does `bash scripts/check.sh` pass?
- Did the agent avoid secrets, personal data, and unrelated changes?

## Examples

### Explanation page

```markdown
---
title: How the telemetry link works
description: The path from the autopilot to the ground station.
owner: Control & Mission Planning
status: draft
last_reviewed: 2026-10-25
tags: [telemetry, mavlink]
---

# How the telemetry link works

## Context

What problem this link solves and where it sits in the system.

## How it works

The flow, the endpoints, and the protocols involved.

## Trade-offs

What is simple, what is fragile, and what was not tested.

## Source

- `atlas_ws/path/to/the/source`
```

### New project page

```markdown
---
title: Project name
description: What the project is trying to achieve.
owner: Project owner
status: draft
last_reviewed: 2026-10-25
tags: [project]
---

# Project name

## Goal

The outcome the project should produce.

## Scope

What is included and what is deliberately out of scope.

## Owner and status

Who owns it, who is helping, and the current state.

## Next steps

- [ ] First concrete step.
- [ ] Second concrete step.

## Links

- Repository, issue, design document, or source file.
```

### Mission page

```markdown
---
title: Mission name
description: What this mission is meant to demonstrate.
owner: Mission owner
status: draft
last_reviewed: 2026-10-25
applies_to: atlas_ws@<commit>
tags: [mission]
---

# Mission name

## Objective

What the vehicle should do and what counts as success.

## Setup

Vehicle, firmware, airframe, location, and simulation or flight environment.

## Procedure

The steps to run the mission.

## Results

What happened. Include the date and the commit or configuration used.

## Open issues

What failed, what is uncertain, and what needs a follow-up.

## Links

- Source files, logs, videos, or related pages.
```

## Before you publish

- Remove placeholders such as `<commit>` and `Project owner`.
- Say what was not tested.
- Do not include credentials, tokens, personal data, or sensitive operational
  details.
- Run `bash scripts/check.sh` again after the final edit.
