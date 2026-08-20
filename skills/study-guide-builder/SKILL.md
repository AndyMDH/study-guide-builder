---
name: study-guide-builder
description: Build grounded, easy-to-understand study material (a study repo, a learning guide, a tutorial, explainer notes) for someone learning a technical topic for the first time. Grounds facts via Exa and Context7, writes in plain short sentences, and applies the density/clarity fixes from the ING document-extraction study repo build. Use when asked to create a study guide, learning material, a tutorial, prep notes for an interview/exam, or to "teach me" / "explain X so I actually understand it" for a technical topic.
---

Build study material that a first-time learner can actually read in one pass, not a reference dump they have to fight through. This skill exists because getting there took several corrective rounds on a real repo (`~/Project/study/ing_document_extraction`) — apply all of those fixes from the start instead of relearning them.

## Step 0 — Ask before you build, not after

A request to "build a study guide for X" is almost never fully specified. Ask before starting work whenever any of these are unclear, rather than guessing and redoing:

- **Where it lives and how big.** One file, or a multi-file repo like the ING one? A specific folder/repo name, or pick a sensible default and confirm it?
- **Depth and audience.** First-time-learner depth (assume no prior exposure, explain from scratch) or a denser refresher for someone who already knows the basics? This changes almost every later decision — don't assume.
- **A specific goal, if any.** Is this for a job interview, an exam, a project, or general learning? A named goal is what makes the "worth asking/raising" callouts in Step 3 possible — without one, skip that part rather than inventing a fake audience.
- **Grounding tool access.** If Exa isn't obviously available (see Step 1), don't silently fall back to WebSearch — say so and ask, or confirm the fallback is fine, before spending a research pass on it.

Mid-build, when feedback arrives on a specific example ("this passage is too dense," "fix this section"), don't assume it's scoped to just that example. Ask, or state your assumption plainly, before deciding whether to apply the fix everywhere or just there — this came up repeatedly during the ING build, and asking once up front is cheaper than a second correction round.

## Step 1 — Ground every fact before writing it

Never write a fact from memory when it is checkable, especially anything fast-moving: product names, API shapes, current SDK versions, pricing, model names.

- **Exa**, if available, is the preferred source. Check thoroughly before concluding it is not available: `EXA_API_KEY` in the environment, in a project `.env` file, and in macOS Keychain (`security find-generic-password -s EXA_API_KEY`). If a key exists, call Exa directly over its REST API with `curl` — no SDK install needed:
  ```bash
  curl -s -X POST 'https://api.exa.ai/search' -H "x-api-key: $EXA_API_KEY" -H 'Content-Type: application/json' \
    -d '{"query":"...","numResults":3,"type":"auto"}'
  ```
  `/contents` with a `urls` array fetches full page text for a specific result.
- If no Exa key is available anywhere, ask the user before silently substituting `WebSearch` — don't just decide and proceed. Burning a research pass on the wrong tool is expensive to redo.
- **Context7** (`resolve-library-id` then `query-docs`) is for library/API-specific documentation — the exact current shape of a function call, a config field, an import path. Prefer it over general web search for anything library-specific.
- If the topic involves a company or product that renames/repositions itself often (this happened mid-build: "Vertex AI" → "Gemini Enterprise Agent Platform"), do a live check even if you're fairly confident — it is cheap insurance against sounding out of date.

## Step 2 — Write in plain, short sentences

If the `simple-english` skill is installed, load it and apply its pragmatic-mode rules throughout. If it isn't installed, apply the same core rules directly: ~25-word sentence limit for descriptive text, active voice, no semicolons, no banned modals (`should`/`would`/`could`/`might` → `can`/`must` or restructure), conditions before commands, no contractions. Domain vocabulary stays (`PDF`, `checkpoint`, `Pydantic`) — this is not about dumbing down content, it's about not making sentences do three jobs at once.

**Do the self-check for real.** After a first pass, re-read the whole document again looking specifically for: sentences over the limit, contractions, `has been`/`have been`, and — the thing that got missed repeatedly on the first attempt — long compound sentences that survived because they were "already kind of short."

## Step 3 — Structure every section the same way

1. **A short "why this exists" framing** — what problem this section solves, tied to the reader's actual goal if there is one (a job, an exam, a project).
2. **A `## Glossary`** near the top, before the main content: every jargon term used in this section, one line each, plain definition. This is the single biggest lever for density — once a term is defined once, the body text can just use it instead of re-explaining it every time it appears. Verify every glossary entry is actually used in the body with `grep` before finishing — no orphaned or invented terms.
3. **The main content**, written to the rule in Step 4.
4. **A "what's next" pointer**, if this is one part of a larger series.

If the material is being built toward a specific goal (an interview, a specific job's tech stack, an exam board), add short callout blocks tying a concept back to that goal — a real, answerable question or observation, grounded only in facts already established, never invented. Format as a blockquote with a bold label, e.g. `> **Worth asking:** ...`. Add these where a concept genuinely connects to the goal, not in every section.

## Step 4 — Cut anything that doesn't change a decision

This was the fix requested most often, and the one most likely to be under-applied on a first pass. The test: **if the reader can use the tool/concept correctly without knowing this fact, and knowing it would not change what they'd build, ask, or decide — cut it, or compress it to one clause.**

This mainly hits internal mechanism/spec detail: file-format internals, obscure API parameters nobody calls directly, statistical derivations, SDK version history, byte-level protocol detail. It does NOT mean cutting real content — keep failure modes, tradeoffs, worked numeric examples, code the reader will actually write, and the reasoning behind a design choice. A worked example with real numbers (e.g. a precision/recall calculation with an actual TP/FP/FN/TN breakdown) is exactly the kind of depth to keep; a page of formula derivation around it is exactly the kind of depth to cut.

**Do not re-derive reasoning already given.** A closing "pulling it together" or summary section should state conclusions in one clause each, not re-argue them — the reasoning already happened earlier in the document. If you catch yourself writing a bullet with 2+ sentences restating an argument from three paragraphs up, cut it to the conclusion alone.

## Step 5 — Visuals: real diagrams and tables, not ASCII art or dense bullets

- **Any branching/decision logic becomes a Mermaid flowchart**, not a numbered list of prose questions and not hand-aligned ASCII arrows in a code block. GitHub (and most modern markdown viewers) render ```mermaid fences natively as real boxes and arrows.
  ```mermaid
  flowchart TD
      A["Does X hold?"] -->|Yes| B["Do Y"]
      A -->|No| C["Do Z instead"]
  ```
  Watch for the anti-pattern that caused a rewrite mid-build: a numbered list where each item is a bolded question (`1. **Does X?** ... 2. **If X, does Y?** ...`) reads as sequential steps but is usually one fork with nested sub-checks. If you're numbering questions, it should probably be a flowchart instead.
- **Any comparison, failure-mode list, or "fact → mitigation" pairing becomes a markdown table**, not a bulleted list of `**Bold fact.** *Mitigation:* ...` pairs. Tables scan faster.
- Keep prose for things that are genuinely sequential reasoning, not branching — a flowchart with one path per node is just a list with extra syntax.

## Step 6 — Add concrete tool namechecks

Wherever a concept maps to a real, specific tool someone would actually reach for, name it — not "a layout-aware parsing tool exists" but "a tool like **Docling** handles this." This came up as an explicit, separate request mid-build: it's the difference between teaching a concept and teaching something actionable.

## Step 7 — If this is a multi-file study repo

- Number files by learning order, and cross-reference between them by **naming the topic**, not a bare number, if any file also has its own internal numbered subsections (`## 1.`, `## 2.`...) — a bare "Section 3" is ambiguous between "the repo's third file" and "this file's own third subsection." Use `§N` for a file's own internal subsections, and name the target topic ("the Pydantic section") for cross-file references.
- Build a master glossary file aggregating every section's glossary, **grouped by topic, not by mirroring the file list 1:1** — merge sections that are really one continuous concern (e.g. "document format" and "getting text out of a document" are one topic told in two files, not two separate topics).
- If you generate derived study aids (a cheat sheet, flashcards, practice questions, a topic-summary refresher), **regenerate them together with the main content, every time it changes.** They drift silently otherwise — this happened mid-build: four derived files sat untouched through six rounds of edits to the source files and ended up contradicting them (testing removed facts, using cut terminology). Sync them in the same pass, not as an afterthought.

## Step 8 — Verify, don't just report done

Before calling a pass finished:
- `grep` for corruption markers (`^<<<<<<<`, `^=======$`, `^>>>>>>>`) if multiple parallel edits touched the same files.
- Confirm code-fence counts are even per file (every code block, including every Mermaid block, opens and closes).
- Confirm every glossary term is actually used in its section's body.
- If parallel agents did the work, actually read a sample of the output yourself rather than trusting each agent's self-report — self-reports describe what an agent intended to do, not always what it did.

## What NOT to do

- Don't cut code blocks, worked examples with real numbers, or the reasoning behind a design decision — only mechanism trivia and restated argument.
- Don't invent facts to fill a glossary or a callout — every entry must trace back to something actually in the content.
- Don't silently swap a preferred tool (Exa) for a fallback (WebSearch) without telling the user first.
- Don't treat "I fixed the one example you pointed out" as done — the user will usually mean "fix this pattern everywhere," and saying so explicitly the first time saves a round trip.
