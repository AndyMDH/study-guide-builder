# Lessons behind the rules

Each rule in `SKILL.md` came from a corrective round on a real study-repo build. This file keeps the stories. Read it when a rule seems optional, or when you want to know what failure it prevents. Identifying details (client names, repo paths, people) are removed.

## Step 0 — Ask before you build

**Scope of feedback.** During one build, feedback arrived repeatedly on single examples ("this passage is too dense"). Each time, the reader meant the pattern, not the instance. Fixing only the pointed-at example cost a second correction round every time. Asking about scope once up front is cheaper.

**Late background reveal.** In one build, content was written on the assumption of Python fluency. Partway through, the reader said they were "decent in Python, basic syntax." The fix was small — a decorator here, a typing construct there — but it required going back through finished files, not just adjusting future writing. The reader will usually reveal their background only once they already feel lost, so ask early.

## Step 1 — Ground every fact

**Product rename mid-build.** A guide referenced "Vertex AI" while the product was repositioning as "Gemini Enterprise Agent Platform." A live check caught it. Renames like this are cheap to check and expensive to ship stale.

**Wrong tool for a research pass.** Falling back from Exa to WebSearch without asking wastes a full research pass if the user wanted the better tool. The key was findable — it sat in the Keychain, not the environment. Search dotfiles, `.env`, and Keychain before you declare a tool unavailable.

## Step 3 — Bridge file

**The case that created the pattern.** A reader had three days to prepare for an interview in the Dutch energy-billing domain. They mentioned, late, that they knew "a bit about mortgages." Energy billing and mortgage escrow are structurally identical: a fixed monthly amount set from an estimate, trued up once a year, with a catch-up letter that generates the support call. The whole domain collapsed into a translation table (`termijnbedrag` = escrow payment, `jaarafrekening` = escrow analysis) instead of twenty new concepts.

**Why "where the analogy breaks" is non-negotiable.** An analogy the reader cannot bound will make them say something wrong. In the energy case, the difference that caused real difficulty: a loan balance is exact, while metered volume stays provisional for weeks.

## Step 4 — File template

**Answers for quick checks.** The self-test questions were well received — and then the reader explicitly asked for answers. A question with no answer is half a feature: a reader who gets it wrong has no way to find out why. That request created the collapsed-answer convention.

**Example before rule.** A reader who sees two near-identical lines of code behave differently remembers the rule that explains why. A reader who meets the abstract rule first usually does not.

**Reference tables in the reading path.** A framework-basics file was built as a grounded reference: a table of agent classes with doc links, a table of CLI commands, a table of state prefixes, rename dates, metric names. The checker passed. The reader said: "this is all complicated, remember how difficult I had it for the last prep? That's my level." What landed instead was one everyday picture (three workers, one whiteboard, a manager) and plain Python before every framework construct. The fix was a split: a short teaching file that opens every section with the plain version, and a `reference_*.md` that holds the tables and the links. Hence the reference-file rule in Step 4 and the citation rule in Step 1.

**Unexplained syntax.** The same reader stalled on `list[RoomMatch]`, `Enum`, `yield`, and `async`, none of which the file explained, because the author read them as obvious. Each needed one line and a picture: a dropdown, several forms in a row, "hand back one thing and continue", "copy it". Ask the reader's Python level in Step 0 and explain every construct above that level where it first appears.

## Step 5 — Cut what changes no decision

This was the fix requested most often, and the one most under-applied on first passes. A worked precision/recall calculation with a real TP/FP/FN/TN breakdown is depth to keep. A page of formula derivation around it is depth to cut.

## Step 6 — Diagrams

**The clipped-node rewrite.** A flowchart packed full explanations into nodes with `<br/>` and `<small>` text. It overflowed the boxes in the reader's renderer. The reader caught it with a screenshot — the author never saw it, because the source looked fine. Short labels in boxes; explanations in prose.

**The numbered-question anti-pattern.** A decision procedure was written as a numbered list of bolded questions (`1. **Does X?** ... 2. **If X, does Y?** ...`). It read as sequential steps but was really one fork with nested sub-checks. It became a flowchart in a rewrite.

## Step 7 — Tool namechecks

This came as an explicit, separate request mid-build: "name the actual tools." It is the difference between teaching a concept and teaching something actionable.

## Step 8 — Multi-file repos

**Derived-aid drift.** Four derived study aids (cheat sheet, flashcards, practice questions, refresher) sat untouched through six rounds of edits to the source files. They ended up testing removed facts and using cut terminology. Nobody noticed until a full read. Regenerate them in the same pass as the source, every time.

**Repo location as an afterthought.** One build produced only loose local files while every sibling study repo of the user's was a private GitHub repo. The user had to ask. Settle location and visibility at Step 0.

## Step 9 — Verify

**The run-on paragraph.** A block of short facts written one per line (`**Interview:** ...` / `**Role:** ...` / `**Start:** ...`) rendered as a single run-on paragraph on GitHub. It shipped, and the reader caught it, not the author — reading the source hides the bug. Hence the render lint.

**The 88% answer-B file.** In one multiple-choice set, 58 of 66 questions had the correct answer at position B. Each question read fine alone; the skew was only visible in aggregate. Guessing B every time scored 88% with zero knowledge, which made the file useless as a self-test. Hence the distribution check — and the script-based shuffle fix, because a manual rewrite gives no mechanical guarantee that options survived intact.

**Agent self-reports.** Parallel agents reported work as done that was not done as described. Self-reports describe intent. Read a sample yourself.
