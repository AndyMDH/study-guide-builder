# study-guide-builder

A Claude Code skill that builds study material for a technical topic you are learning for the first time. It works for a study repo, a learning guide, or notes for an interview or exam.

It is an agent skill, not a program. Claude Code reads the instructions and follows them. There is nothing to run.

[![License: MIT](https://img.shields.io/badge/license-MIT-C2410C)](LICENSE)

## Why

AI-written study notes have three common problems:

- They are too dense. They read like a spec, not a lesson.
- They define jargon inline, again and again, or not at all.
- They turn branching logic into prose questions that you cannot follow.

Fixing these on a real study repo took about a dozen rounds of corrections. This skill applies all those fixes from the first draft.

## What it does

**Before it writes:**

- Asks you a few clickable questions: scope, time budget, and goal. Each has a recommended answer.
- Gives you a short quiz. Your answers, not your self-report, set the depth.
- If you know a related domain, writes a bridge file first. It maps what you know onto what you are learning.

**While it writes:**

- Checks every fact with [Exa](https://exa.ai) and [Context7](https://context7.com). It never writes a version, price, or product name from memory.
- Uses short sentences and active voice.
- Gives every file the same shape: why it exists, a glossary, the content, a self-test, and what comes next.
- Opens each section with a real example before the rule.
- Draws decision trees as Mermaid flowcharts. Puts comparisons in tables.
- Cuts anything that does not change a decision.
- Names real tools.

**After it writes:**

- Checks that every glossary term is used.
- Checks that code fences and details blocks are closed.
- Checks that multiple-choice answers are spread evenly across A, B, C, and D.

The full rules are in [`SKILL.md`](skills/study-guide-builder/SKILL.md). The stories behind each rule are in [`references/lessons.md`](skills/study-guide-builder/references/lessons.md). Rules for material that follows a slide deck are in [`references/slide-decks.md`](skills/study-guide-builder/references/slide-decks.md).

## Install

As a plugin:

```
/plugin marketplace add AndyMDH/study-guide-builder
/plugin install study-guide-builder
```

As a plain skill folder:

```bash
git clone https://github.com/AndyMDH/study-guide-builder.git
cd study-guide-builder
./install.sh
```

The script links the skill into `~/.claude/skills`. Add `--project` to install into the current project only. Add `--copy` to copy the files instead of a link.

## Use

Ask Claude Code in plain words:

- "Build me a study guide for X."
- "I have an interview about Y next week. Help me learn it."
- "Explain Z so I actually understand it."

## Optional

- An `EXA_API_KEY` gives better grounding on fast-moving topics. Without it, the skill asks before it falls back to web search.
- The `simple-english` skill gives the full sentence-level rule set. Without it, this skill applies the core rules itself.

## License

MIT. See [LICENSE](LICENSE).
