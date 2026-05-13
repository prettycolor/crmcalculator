# CRM audit question bank v2 — implementation plan

> **For agentic workers:** Use task checkboxes for tracking. Spec: [`docs/2026-05-13-crm-audit-question-research.md`](../2026-05-13-crm-audit-question-research.md).

**Goal:** Ship **15** research-backed audit questions, **proportional** scoring (max **75**), dual hash **`v=1` / `v=2`**, and updated copy.

**Architecture:** Single-file [`index.html`](../../index.html); constants `QUESTION_COUNT`, `MAX_AUDIT_SCORE`, `CAT_MAX_POINTS`; `validatePayload` branches on `p.v`; `tryConsumeHashOnLoad` accepts both hash prefixes.

**Tech stack:** Vanilla JS, existing HTML/CSS.

---

### Task 1: Constants and question data

**Files:** [`index.html`](../../index.html)

- [x] **Step 1:** After `questions` array, set `const QUESTION_COUNT = questions.length` (must be 15), `MAX_AUDIT_SCORE`, `CAT_MAX_POINTS = MAX_AUDIT_SCORE / categories.length`.
- [x] **Step 2:** Replace `questions` with 15 merged strings (see spec matrix).

### Task 2: Payload and hash versioning

- [x] **Step 1:** `getSharePayload()` returns `v: 2`.
- [x] **Step 2:** `validatePayload()` accept `v === 1 || v === 2`; use `n = p.v === 2 ? 15 : 20` for length checks.
- [x] **Step 3:** `copyResumeLink` / write path use `#v=2&d=` prefix constant.
- [x] **Step 4:** `tryConsumeHashOnLoad` parse `v=1&d=` or `v=2&d=` (same slice length 6).

### Task 3: Progress and navigation

- [x] **Step 1:** `getProgressTotal()` → `QUESTION_COUNT + 2` (no gate) or `+3` (gate).
- [x] **Step 2:** Replace literals `20`, `21`, `22` in `answer`, `applyPayload`, `onCalcSubmit`, `renderQuestion` with formulas using `QUESTION_COUNT`.
- [x] **Step 3:** `syncProgressAriaMax` runs after constants are defined (uses `getProgressTotal`).

### Task 4: Results UI and scoring

- [x] **Step 1:** `showResults`: grade bands on `total / MAX_AUDIT_SCORE`; pipeline risk same ratio; live region text.
- [x] **Step 2:** Category rows: `pct = (score / CAT_MAX_POINTS) * 100`; thresholds `< CAT_MAX_POINTS * 0.4` and `< 0.8 * CAT_MAX_POINTS`; labels `score/CAT_MAX_POINTS`.
- [x] **Step 3:** HTML: `id="scoreOutOf"` for dynamic `/ 75`; update intro + results `<p class="sub">`.

### Task 5: Docs and README

- [x] **Step 1:** [`README.md`](../../README.md) — question count, hash v2, backward compatibility note.

### Task 6: Manual verification

- [x] Complete audit (15), calc, results; grades match old proportions.
- [x] Copy link → new hash `v=2`; reload with resume prompt; restore.
- [x] (Optional) craft or keep old `v=1` 20-answer payload in fixture — restore still works.

---

## Completion

Execute Task 1–6 in order; single commit recommended: `feat: research-backed 15-question audit (v=2 hash)`.
