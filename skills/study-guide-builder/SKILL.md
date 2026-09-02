---
name: study-guide-builder
description: Build grounded, easy-to-understand study material (a study repo, a learning guide, a tutorial, explainer notes) for someone learning a technical topic for the first time. Grounds facts via Exa and Context7, writes in plain short sentences, and applies density/clarity fixes learned on real study-repo builds. Use when asked to create a study guide, learning material, a tutorial, prep notes for an interview/exam, or to "teach me" / "explain X so I actually understand it" for a technical topic.
---

Build study material that a first-time learner can read in one pass, not a reference dump. Every rule below came from a corrective round on a real build. The stories behind the rules are in `references/lessons.md` — read it when a rule seems optional or unclear. If the material pairs with a slide deck, also read `references/slide-decks.md`.

Terminology in this skill: a **file** is one markdown file in the study repo. A **§section** is a numbered heading inside one file. Never write a bare "Section 3" in the material — name the target file, or use `§3` for the current file.

## Step 0 — Grill before you build

A request to "build a study guide for X" is never fully specified. Do not start writing from the request alone. Run an intake in rounds of clickable questions (the AskUserQuestion tool). Give every question a recommended option, marked "(Recommended)" and listed first. After each round, ask whatever the answers unblocked. Stop when nothing that shapes the guide is unsettled.

**Round 1 — scope.** Ask in one round:

- **Where it lives and how big.** One file, or a multi-file repo? Which folder or repo name? For a repo, settle GitHub and visibility now (see Step 8).
- **Depth, self-reported.** First-time learner, or a denser refresher? This is a claim, not a fact — round 2 tests it.
- **Adjacent domain.** What does the reader already know? This unlocks the bridge file (Step 3).
- **Goal.** Interview, exam, project, or general learning? With no goal, skip the goal callouts in Step 4 and the goal round below.
- **Time budget.** Three days and three weeks produce different guides. Scope file count and depth to the answer.
- **Grounding access.** If Exa is not available (Step 1), ask before you fall back to WebSearch.

**Round 2 — calibration quiz.** Ask 3 to 5 multiple-choice questions on the topic, pitched at the depth the reader claimed. Ground the quiz facts first (Step 1) — a calibration quiz with a wrong answer key miscalibrates everything after it. Their answers, not the self-report, set the starting level: a wrong answer marks something the guide must teach from scratch; a confident right answer marks something to compress or skip. This exists because self-reports arrive vague and late (see `references/lessons.md`).

**Round 3 — goal interrogation** (only with a named goal). Work backwards from the event: What will you be asked? What must you be able to do on day one? What does failure look like? The answers become the targets for the "Worth asking" callouts and the self-tests.

Mid-build feedback on one example ("this passage is too dense") usually means "fix this pattern everywhere." Ask, or state your scope assumption, before you apply the fix.

When the reader reveals their real background partway through despite the quiz, go back and patch what is already written. Do not only adjust future writing. The gap is usually small and cheap to fix.

## Step 1 — Ground every fact

Never write a checkable fact from memory. This holds hardest for fast-moving facts: product names, API shapes, SDK versions, pricing, model names.

- **Exa** is the preferred search tool. Check for a key before you conclude that it is absent: the `EXA_API_KEY` environment variable, a project `.env` file, and macOS Keychain. Extract from Keychain with:
  ```bash
  export EXA_API_KEY="$(security find-generic-password -s EXA_API_KEY -w)"
  ```
  Then call the REST API directly — no SDK install needed:
  ```bash
  curl -s -X POST 'https://api.exa.ai/search' -H "x-api-key: $EXA_API_KEY" -H 'Content-Type: application/json' \
    -d '{"query":"...","numResults":3,"type":"auto"}'
  ```
  `/contents` with a `urls` array fetches full page text for a result.
- If no key exists anywhere, ask before you substitute WebSearch.
- **Context7** (`resolve-library-id`, then `query-docs`) covers library-specific facts: exact call shapes, config fields, import paths. Prefer it over web search for those.
- Live-check any company or product that renames itself often, even when you feel confident.
- **Cite load-bearing facts inline.** A version, price, product name, or date gets a markdown link to its source at the point of use. Ordinary explanatory prose stays link-free.

## Step 2 — Plain, short sentences

If the `simple-english` skill is installed, load it and apply pragmatic mode throughout. If not, apply its core rules directly: ~25-word sentence limit for descriptive text, active voice, no semicolons, no `should`/`would`/`could`/`might`, conditions before commands, no contractions. Domain vocabulary stays — this is about sentence load, not dumbing down.

After the first pass, re-read the whole document once more. Hunt for: over-limit sentences, contractions, `has been`/`have been`, and long compound sentences that felt "already kind of short."

## Step 3 — Bridge file (file `00`)

If the topic is new to the reader but they know an adjacent domain, write a bridge file first, numbered `00`. Do not teach a domain from first principles when the reader owns the same machine under different names.

Four parts, in this order:

1. **The claim, stated plainly.** "These are the same mechanism." Then one worked example told twice — once in the familiar domain, once in the new one, same shape and numbers.
2. **The translation table.** Familiar term, new term, and a third column that names the shared idea. The third column stops it becoming rote vocabulary.
3. **Where the analogy breaks.** Non-negotiable, and usually the most valuable part. Name the differences, and say which one causes the real difficulty.
4. **The short retention list.** About nine terms, not forty. Name the three that carry most of the conversation.

Ground the familiar side too — check it like any other fact.

## Step 4 — One template for every file

1. **A short "why this exists" framing** — what problem the file solves, tied to the reader's goal when there is one.
2. **A `## Glossary`** before the main content: every jargon term used in the file, one plain line each. This is the biggest density lever — define once, then use. (Usage is verified in Step 9.)
   A glossary row is not an explanation. Explain each term in the body where it first matters: the definition, the thing it replaces, and the consequence for this project. A file that states conclusions without laying that ground reads as ammunition, not learning material.
3. **The main content**, written to the Step 5 cut rule. Lead each §section with a concrete example, then the general rule. Reorder any passage that does it the other way.
   For any multi-step process, show a worked trace with the output of every step — the actual input, what each step produces, what comes back. A numbered list of step names teaches nothing on its own.
4. **A "Quick check" at the end of each major §section** — one question that applies the concept to a new scenario, never "summarize this". Use the same collapsed-answer markup as every other Q&A aid (Step 8):
   ```
   > **Quick check:** <question>

   <details>
   <summary>Answer</summary>

   <the answer, then the reasoning — 1 to 4 sentences, tied only to content already in this file>

   </details>
   ```
5. **A "what's next" pointer**, if the file is part of a series.

With a named goal, add sparse callouts: `> **Worth asking:** ...` — a real, answerable question grounded only in established facts. Add one only where a concept genuinely connects to the goal, not in every file.

## Step 5 — Cut what changes no decision

The test: can the reader use the concept correctly without this fact? Would knowing it change what they build, ask, or decide? If no to both, cut it or compress it to one clause.

This mainly hits mechanism trivia: file-format internals, obscure parameters nobody calls, statistical derivations, version history, byte-level detail. Keep failure modes, tradeoffs, worked numeric examples, code the reader will write, and the reasoning behind design choices.

Do not re-derive reasoning in summaries. A closing section states each conclusion in one clause — the argument already happened earlier.

## Step 6 — Real diagrams and tables

- Branching or decision logic becomes a Mermaid flowchart — never ASCII arrows, never a numbered list of bolded questions. If you are numbering questions, it is probably a flowchart.
- A comparison, failure-mode list, or fact-and-mitigation pairing becomes a markdown table.
- Genuinely sequential reasoning stays prose. A flowchart with one path per node is a list with extra syntax.
- Keep every Mermaid node label to a handful of words. The explanation goes in the surrounding prose, not in `<br/>`-packed node text — long labels clip in real renderers.

## Step 7 — Concrete tool namechecks

Where a concept maps to a real tool, name it: not "a layout-aware parsing tool exists" but "a tool like **Docling** handles this." Named tools are the difference between a concept and something actionable.

## Step 8 — Multi-file repos

- **Settle location, GitHub, and visibility at Step 0.** Check `gh repo list` and match the user's existing pattern — loose local files are not finished when every sibling repo lives on GitHub. Study material often names real people and the reader's weaknesses: fine in a private repo, not fine in a public one. Ask before you push.
- Number files by learning order. Cross-file references name the topic ("the Pydantic file"), never a bare number. `§N` refers only to the current file's own sections.
- Build a master glossary grouped by topic, not 1:1 by file — merge files that are one continuous concern.
- Derived aids (cheat sheet, flashcards, practice questions, refreshers) regenerate together with the source content, every pass. They drift silently otherwise.
- **Every Q&A aid hides its answer in a collapsed `<details>` block** — flashcards, practice questions, multiple-choice tests, and quick checks. No visible answer-key tables anywhere: an answer the eye can reach before the guess defeats retrieval.

  ```
  **Q: <question>**

  <details>
  <summary>Answer</summary>

  <the answer, then the reasoning — 1 to 4 sentences>

  </details>
  ```

  For a multiple-choice question, the first line inside the block is `**Answer: <letter>**`, then the reasoning.

  Three mechanics: keep a blank line after `<summary>` and before `</details>` (GitHub renders literal HTML otherwise); never ship `<details open>`; one question per `<details>` block.

  Check mechanically before finishing:
  ```bash
  grep -c '<details>' cards.md && grep -c '</details>' cards.md   # counts must match
  grep -n '<details open' cards.md && echo 'FAIL: pre-opened answer'
  ```

## Step 9 — Verify, do not just report done

- If parallel edits touched the same files, grep for corruption markers (`^<<<<<<<`, `^=======$`, `^>>>>>>>`).
- Code-fence count per file must be even: `` grep -cE '^[[:space:]]*```' file.md ``. The pattern must allow indentation, or fences inside list items go uncounted. Every block, including Mermaid, opens and closes.
- Every glossary term must appear in its file's body — check with grep, no orphaned or invented terms.
- After inserting a new section (a primer, a bridge) ahead of existing content, re-check reading order: the new section must not reference an example that only appears later.
- If parallel agents did the work, read a sample of the output yourself. Self-reports describe intent, not results.
- **Check that the file renders as written.** Markdown joins consecutive non-blank lines into one paragraph, so stacked `**Label:** value` lines become a run-on paragraph on GitHub. Two rules: a block of label-and-value facts is a two-column table, never stacked lines; a bold label above a list or table needs a blank line. Lint mechanically:
  ```bash
  python3 - <<'EOF'
  import glob
  for f in glob.glob('*.md')+glob.glob('*/*.md'):
      L=open(f).read().split('\n'); fence=False; run=[]
      def flush():
          if len(run)>1: print(f"{f}:{run[0]} -- {len(run)} lines merge into one paragraph")
      for i,l in enumerate(L,1):
          s=l.strip()
          if s.startswith('```'): fence=not fence; flush(); run.clear(); continue
          if fence: continue
          if not s or s[0] in '|#>-<[' or s.startswith('* ') or s[:2].rstrip('.').isdigit() or l.endswith('  '):
              flush(); run.clear(); continue
          run.append(i)
      flush()
  EOF
  ```
  List items and deliberate soft-wrapped prose are false positives. The targets are stacked facts and stacked labels.
- **Check the multiple-choice answer-letter distribution, not just each question's content.** Count the letters inside the `<details>` blocks:
  ```bash
  grep -oE '\*\*Answer: [A-D]\*\*' file.md | sort | uniq -c
  ```
  Zero matches means the format drifted — fix the file or the pattern; never accept an empty result as a pass. If the distribution skews, fix it with a script that shuffles each question's options and rewrites the answer lines. Then verify mechanically: the set of option texts per question is unchanged, and every answer letter still points at the originally correct option.

## What NOT to do

- Do not cut code blocks, worked examples with real numbers, or the reasoning behind a design decision — only mechanism trivia and restated argument.
- Do not invent facts to fill a glossary or a callout — every entry must trace to something in the content.
- Do not silently swap Exa for WebSearch — tell the user first.
- Do not treat "I fixed the one example you pointed out" as done — say explicitly whether you fixed the pattern everywhere.
