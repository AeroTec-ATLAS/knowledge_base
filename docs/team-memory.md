---
title: Team memory and AI wiki
description: How ATLAS uses the knowledge base as shared team memory and an AI-readable wiki.
owner: ATLAS
status: draft
last_reviewed: 2026-10-25
tags: [team, ai, docs]
---

# Team memory and AI wiki

This site is not only documentation. It is the team's shared memory: what was
tried, what worked, what is still open, and where the source lives. It is also
the context an AI agent reads before it helps with code, missions, or planning.

For the mechanics of adding or editing a page, see
[Using the knowledge base](using-the-knowledge-base.md).

## What this gives the team

- A single place for decisions and the reasons behind them.
- A starting point for someone joining a project or area.
- A record of missions, tests, and experiments that is easier to find than a
  chat history.
- Context for AI agents, so they do not start from zero on every task.
- A place to keep links to source, logs, and issues without copying everything.

## What belongs here

| Content | Example |
|---|---|
| Explanation | How a subsystem works, or why a design was chosen. |
| Project | Goal, scope, owner, status, next steps, and links. |
| Mission | Objective, setup, procedure, results, and open issues. |
| How-to | A task that someone needs to repeat. |
| Reference | Commands, parameters, ports, or configuration. |
| Decision record | What was decided, when, by whom, and what was rejected. |

A page can start small. Three clear paragraphs with a source link are more
useful than a long page with no owner and no verification.

## Write for memory, not for a meeting

- One concept per page. Split pages that grow past a few screens.
- Start with the question the page answers.
- Link the source instead of copying large code blocks.
- Record the date, commit, and what was not tested.
- Use explicit nouns. Avoid ambiguous “it” and “this”.
- Give every page an owner and a review date.
- Keep a page `draft` until someone checks it.

## If you are developing something

Create a project page before the work becomes hard to reconstruct. Start with:

```markdown
## Goal

## Scope

## Owner and status

## Next steps

## Links
```

As the work moves, add mission pages, experiment notes, and decisions to the
project page. At the end, record the result, what failed, and what still needs a
follow-up. The project page becomes the memory of the work, not a status report
that disappears after the sprint.

## How AI uses this site

- `AGENTS.md` contains the rules an agent must follow.
- `docs/llms.txt` is the compact index of pages.
- `docs/llms-full.txt` is every page concatenated in navigation order.
- The `nav` in `mkdocs.yml` defines the reading order.

An AI agent should read the relevant page and its linked source. The code wins
over the page when they disagree. The agent should not invent commands, ports,
parameters, or results, and it should say what it could not verify.

### Ask AI to use the knowledge base

Use a prompt like this when you want an answer from the site:

```text
Read AGENTS.md and the pages about <topic>. Answer <question>.
Cite the page or source file for each claim. If the answer is not in the
knowledge base, say so and check the code.
```

Use a prompt like this when the memory needs to change:

```text
Read <page> and <source>. Update the page to match the current code.
Keep status: draft until I verify it. Record the commit and what was not tested.
Do not change unrelated pages.
```

### Ask AI to review the memory

An agent can also look for problems across the site:

```text
Review the pages under <area>. Find stale links, claims without a source,
commands that no longer match the code, and pages that should be marked stale.
Do not rewrite the pages. List the problems and the source you checked.
```

## What not to put here

- Credentials, tokens, personal data, or sensitive operational details.
- Large code blocks, raw logs, or datasets. Link to them instead.
- Guesses presented as facts.
- Meeting transcripts without a short summary.
- Pages without an owner or a review date.

## Keep it current

- Update `last_reviewed` when you review a page.
- Move `status` from `draft` to `verified` only after checking the content.
- Mark a page `stale` when the code has moved on.
- Keep `deprecated` pages for history instead of deleting them.
- When a page is renamed, update the links and the navigation.

The knowledge base is useful only while the team trusts it. A small, current
page with a clear source is better than a complete page that nobody has checked.
