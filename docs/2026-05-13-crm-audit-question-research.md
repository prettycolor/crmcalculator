# CRM audit question bank — research and design (OkayBabe CRM beta)

**Date:** 2026-05-13  
**Scope:** Consolidate the interactive CRM health audit from **20** to **15** questions (under the **22** cap), preserve five category pillars, and version shareable URL state (`v=2`).

---

## Phase A — Design intent (Superpowers brainstorming)

**Purpose for OkayBabe CRM beta**

- **Qualify** inbound interest without feeling like a long survey.
- **Educate** on gaps (data, pipeline, follow-up, reporting, tool fit) so the beta CTA feels earned.
- **Trust:** one question per screen, clear progress, no dark patterns.
- **Handoff:** results + action plan point toward beta signup; optional email gate (`?gate=1`) stays separate.

**Constraints**

- Mobile-friendly (thumb targets, short copy).
- **Time promise:** intro badge targets **~3 minutes** for 15 × Yes / Partially / No (down from ~4 min for 20).
- **Scoring:** keep 5 / 3 / 0 per answer; **max raw score = 75** (15 × 5). Grades use **percentage of max** so A/B/C/D bands match prior intent (80% / 60% / 40% thresholds).
- **No duplicate signal:** merged overlapping items within each category (see matrix).

**Success criteria**

- One click always advances; completion **without** unnecessary drop-off (see research).
- Category bars and action plan still differentiate weak vs strong areas.
- **Backward compatibility:** saved links with `v=1&d=…` and **20** answers still validate and restore.

---

## Phase B — Research appendix (Exa / web)

Sources are indicative of industry practice; they are not okaybabe-specific experiments.

1. **Survey length and completion** — SurveyMonkey (State of Surveys): average survey length fell (~13.2 → ~11 questions 2017–2023); methodologists recommend staying **short**, often **≤10 questions per “page”** and **capping around 25** for general use. https://www.surveymonkey.com/curiosity/what-our-latest-research-uncovered-about-survey-length  
2. **B2B / transactional length** — HubSpot blog (2025): cites drop-off with added length; **7–10 questions** cited for milestone-style surveys; **Qualtrics** reference ~**12 min** ( **9 min mobile** ) break-off risk. https://blog.hubspot.com/service/ideal-survey-length  
3. **Controlled evidence** — Quackback (2026 roundup): **7–10 questions** / **<5 minutes** “strongest experimental evidence”; ~**17% drop-off** when exceeding **12 questions** or **5 minutes** (vendor-style aggregate claim). https://quackback.io/blog/improve-survey-response-rates  
4. **Distribution of survey sizes** — Survicate: large share of surveys in **1–5** and **6–10** buckets; **11–20** still common with mid-70s% completion in their sample (context: mix of use cases). https://survicate.com/blog/how-many-questions-should-surveys-have  
5. **Time per question** — SurveyMonkey analysis: satisficing increases with length; **keep under ~10 minutes** for engagement. https://www.surveymonkey.com/curiosity/survey_completion_times/  
6. **CRM / RevOps diagnostics (competitive landscape)** — Public tools often use **6–8** headline questions (e.g. WE Interactive 6-step CRM assessment; HelloGrowth RevOps maturity **8** questions) while deeper Excel frameworks use **many more** dimensions (Demand Metric CRM maturity **15** categories) — productized web flows skew shorter than consultant-grade Excel.  
   - https://crm.we-interactive.com/  
   - https://hellogrowthcrm.com/tools/revops-maturity-assessment  
   - https://www.demandmetric.com/content/crm-maturity-assessment  

**Synthesis for “perfect N” (< 22)**

- **15 questions** ( **3 per category × 5** ) is the **primary recommendation:**  
  - Clearly **< 22** and **shorter than 20** for completion and cognitive load.  
  - Keeps **symmetric** category weights (same story as today’s UI).  
  - Aligns with “**~10–15 items**” comfort zone in multiple vendor summaries without collapsing to a toy **6-question** quiz that loses differentiation for beta positioning.  
- **Fallback:** **18** (e.g. 4+4+4+3+3) if sales/marketing insist on an extra Tool Fit + Reporting item each — still under 22; document as Phase 2 if needed.

---

## Phase C — Coverage matrix (20 → 15)

| # (old) | Category | Old question (abridged) | Merged into (new #) |
|--------|-----------|-------------------------|---------------------|
| 1, 4 | Data Hygiene | Stale removal; duplicates | **1** Single hygiene + ownership habit |
| 2, 3 | Data Hygiene | Updates after interactions; history <30s | **2** Updates for context; **3** History in ~1 min |
| 5, 8 | Pipeline | Count by stage; untouched > week | **4** Live by stage; **5** Cycle + idle time |
| 6, 7 | Pipeline | Cycle length; assigned + next step | **5** and **6** |
| 9, 11, 12 | Follow-up | 24h; automation; sequence | **7** 24h; **8** automation anti-cold; **9** logging discipline |
| 10 | Follow-up | Log consistently | **9** |
| 13, 14, 15 | Reporting | Weekly review; win by source; stage losses | **10** forecast; **11** weekly metrics; **12** loss diagnosis |
| 16–19 | Tool Fit | Adoption; integration; mobile; saves time | **13–15** (combined mobile + desktop “prefer CRM” framing) |

New question texts are in [`index.html`](../index.html) `questions` array (source of truth).

---

## Phase D — Scoring and hash strategy

- **Raw max:** `QUESTION_COUNT * 5` → **75**.  
- **Grades:** `total / MAX >= 0.8` → A, `>= 0.6` → B, `>= 0.4` → C, else D (same proportional cutoffs as 80/60/40 on a 0–100 scale).  
- **Category max per bar:** **15** points; bar color breakpoints at **40% and 80%** of category max → **6** and **12** (was 8 and 16 for max 20).  
- **Pipeline “revenue at risk”:** use same **relative** thresholds vs max score.  
- **Share payload:** `v: 2` in JSON; URL prefix **`#v=2&d=`** for new links. **`v: 1` + 20 answers** still accepted for restore.

---

## Phase E — Reality check (lightweight)

Applied inline against research claims: no medical/legal overreach; question counts from Exa are **industry guidance** not guarantees for okaybabe’s audience; self-assessment **bias** remains (see Demand Metric / maturity literature). Marketing copy should not imply statistical certification.

---

## Results methodology block (transparency copy, 2026)

**Design intent (brainstorming):** Primary job is **trust + comprehension** before the pipeline and action-plan cards; secondary is reinforcing OkayBabe beta positioning **without** repeating the join CTA. Ship as **scannable bullets** only (no in-card privacy accordion); hash/gate behavior stays in README. Mobile CRO patterns informed density (e.g. [6th Man Digital — landing page conversion](https://www.6thman.digital/articles/how-to-design-winning-landingpages), [mobiledominate.com — progressive disclosure](https://mobiledominate.com/mobile-landing-page-best-practices-that-convert/) as background only).

**External patterns (Exa, indicative):** Maturity and audit experiences often add an FAQ or “how calculated” line (e.g. [Marketing Alchemists assessment FAQ](https://marketingalchemists.com/marketing-maturity-assessment/) — score range explained in plain language; [ActiveCampaign AI maturity quiz](http://activecampaign.com/lp/ai-maturity-quiz) — methodology paragraph; [WhatAreTheBest.com — methodology](https://whatarethebest.com/how-we-evaluate.cfm) — explicit limits of the framework). okaybabe copy stays **shorter** and **non-competitive** (no third‑party product scores).

**Public copy guardrails:** No certification or peer benchmark claims; state self‑reported answers, 5/3/0 → max 75, letter grades from **percentage of max**; pipeline dollars **user‑entered**, separate from audit.

## Next steps

See [implementation plan](superpowers/plans/2026-05-13-crm-audit-question-bank-v2.md) and [ROADMAP](../ROADMAP.md) “Question bank v2”.
