# When the material pairs with a slide deck

Rules for study material that shadows an existing course deck (someone else's slides, your study text). Learned on a real course-shadowing build, after three restructures.

- **Teach first, show the slides after.** Each block file reads: glossary → `§N.0 Basics` (everything the slides assume, taught from scratch, in learning order, nothing "too basic") → `§N.1 ...` content sections → a pointer to the slides and the exercise. Do not interleave slide images with the teaching — the reader called that "two conversations."
- **Number files by course block**, not by reading order. A reader who sees file 4 asks why block 4 is there. Gaps are fine (`1, 2, 3, 5a, 5b, 8`).
- **One `practice-deck.md`**: every slide as an image, in deck order, with deck numbers, a "Taught in §..." link into the block file, and a correction under any slide whose own claim is wrong or stale. Build it from the deck by title, so that notes survive renumbering. Render images from the deck itself, not from the source course's other decks.
- **A section that restates the slide is not teaching.** Every `§N.x` needs the mechanism, a worked example on the course's real code with the actual prompt and what comes back, the failure modes as a table, and a quick check that applies the idea to a new situation. The reader's words on a restating section: "there's nothing explained here." Audit for it — the first pass always has some.
- **Corrections belong in the study text and under the slide, never in the slide image.** The images are someone else's course; the text is yours.
- **Exercise text does not live in the learn files.** Link to the exercise sheet and to `exercises/README.md`.
