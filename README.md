<p align="center">
  study-guide-builder is a Claude Code agent skill. It builds study material
  — a study repo, a learning guide, interview or exam prep notes — for
  someone learning a technical topic for the first time.
</p>

<p align="center">
  This is an agent skill. Claude Code, or any <code>AGENTS.md</code>-reading
  agent, follows these instructions directly. There is no package to
  install and no service to run.
</p>

<p align="center">
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-C2410C"></a>
</p>

## Why

Most AI-generated study content has the same three problems: it's too dense
(jargon-heavy paragraphs that read like a spec, not a lesson), it re-explains
every term inline instead of once, and any branching logic ("does this need
OCR or not?") ends up as prose questions instead of something you can
actually follow.

This skill exists because fixing those problems, on a real study repo, took
around a dozen separate rounds of corrections. Each round fixed a real,
specific failure:

1. Wrote it in Simplified Technical English (short sentences, active voice).
2. Defined jargon inline the first time it appeared — still too dense.
3. Cut internal mechanism/spec trivia that didn't change any decision.
4. Added a `## Glossary` per section so terms get defined once, not every time they're used.
5. Grouped a master glossary by topic instead of mirroring file structure 1:1.
6. Converted every ASCII decision tree and dense bullet list into a real Mermaid flowchart or table.
7. Shortened Mermaid node labels after long ones overflowed their boxes in some renderers.
8. Reordered sections to lead with a concrete example before the general rule.
9. Added a self-test question at the end of each subsection — with a collapsed answer, not just a bare question.
10. Recalibrated already-written content once the reader's real background level became clear.
11. Found and fixed a severe answer-position bias in a multiple-choice self-test (88% of answers had drifted to the same letter) with a verification script, not a manual rewrite.

The skill applies all of these from the first draft, instead of relearning
them one complaint at a time.

## What it does

- **Grounds facts** via [Exa](https://exa.ai) (checked thoroughly before
  falling back to `WebSearch`, and asks first) and
  [Context7](https://context7.com) for library-specific API detail — never
  writes a checkable fact from memory. Load-bearing facts (versions,
  prices, product names, dates) get an inline source link at the point of
  use.
- **Writes in plain, short sentences** — Simplified Technical English rules,
  loading the `simple-english` skill if
  it's installed, or applying the same rules directly if not.
- **Structures every section the same way**: why this exists → a glossary
  (terms defined once) → the content → what's next.
- **Cuts anything that doesn't change a decision** — keeps failure modes,
  tradeoffs, and worked examples; cuts mechanism trivia and restated
  reasoning.
- **Draws real diagrams, with short labels.** Branching logic becomes a
  Mermaid flowchart, not a numbered list of prose questions. Comparisons and
  failure-mode lists become tables, not dense bullets. Node text stays short
  so it doesn't overflow its box.
- **Leads with examples.** Each subsection opens with a concrete case before
  the general rule, shows a worked trace with the output of every step, and
  closes with a self-test question that has a real, collapsed answer — not a
  bare question with no way to check yourself. Every Q&A aid, multiple-choice
  included, uses the same `<details>` markup.
- **Names real tools**, not "a tool exists for this."
- **Grills before building.** Runs an intake in rounds of clickable
  questions, each with a recommended answer: scope and time budget first,
  then a short grounded calibration quiz of the reader (their answers, not
  their self-report, set the depth), then goal interrogation when there is
  an interview or exam to prepare for. Recalibrates already-written content
  if it learns the reader's real background partway through.
- **Writes a bridge file first** when the reader knows an adjacent domain:
  the claim that the two are the same mechanism, a translation table, where
  the analogy breaks, and a short retention list.
- **Verifies its own output**, not just reports done — even code fences,
  no orphaned glossary terms, reading order after inserts, stacked lines
  that would merge into one paragraph on GitHub, and an even spread of
  correct answers across A/B/C/D in multiple-choice self-tests, since that
  kind of bias is invisible reading one question at a time.

See [`skills/study-guide-builder/SKILL.md`](skills/study-guide-builder/SKILL.md)
for the full instructions the agent follows. Two reference files sit next
to it:

- [`references/lessons.md`](skills/study-guide-builder/references/lessons.md)
  — the story behind each rule: the real failure on a study-repo build that
  the rule prevents. Read it when a rule seems optional.
- [`references/slide-decks.md`](skills/study-guide-builder/references/slide-decks.md)
  — extra rules for material that shadows an existing course deck.

## Install

**As a plugin** (recommended — updates when you pull):

```
/plugin marketplace add AndyMDH/study-guide-builder
/plugin install study-guide-builder
```

**As a standalone skill**, without the plugin system:

```bash
git clone https://github.com/AndyMDH/study-guide-builder.git
cd study-guide-builder
./install.sh              # symlinks into ~/.claude/skills/study-guide-builder
```

Add `--project` to install into the current project only, or `--copy` to
copy instead of symlink.

## Using it

Once installed, just ask normally — Claude Code loads the skill on
requests like:

- "Build me a study guide for X."
- "I have an interview about Y next week, help me learn it."
- "Explain Z so I actually understand it, I'm learning this for the first time."

## Optional but recommended

- An `EXA_API_KEY` for stronger, more current grounding on fast-moving
  topics (product names, API shapes, current SDK versions). Without it, the
  skill uses `WebSearch` and Context7 instead, and will ask before doing so.
- The `simple-english` skill installed alongside this one, for its full
  sentence-level rule set. Not required — study-guide-builder applies the
  core rules directly if it's absent.

## License

MIT — see [LICENSE](LICENSE).
