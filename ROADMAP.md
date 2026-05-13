# CRM calculator — roadmap

| Phase | Status | Summary |
|-------|--------|---------|
| **1** | Complete | Single-page audit + calculator, design tokens, theme (system / light / dark), accessibility baseline |
| **2** | Complete | Icons, print stylesheet, shareable state via URL hash (`#v=2&d=…` for new links; legacy `#v=1&d=…` for 20-answer snapshots), resume banner + `?restore=1` |
| **3** | **Shipped (this repo)** | Embed mode (`?embed=1`), `postMessage` auto-height, URL theme override, optional email gate (`?gate=1`), lead POST hook + analytics placeholder, docs |

## Phase 3 — shipped in this commit

- **Embed**: `?embed=1` or `embed=true` adds `html.embed` (header hidden for minimal chrome). Parent listens for `{ type: 'crmcalc-resize', height }` (see README).
- **Theme**: `?theme=dark|light|system` overrides stored preference; theme toggle hidden when the param is present or in embed mode.
- **Email gate**: Off by default; `?gate=1` enables the “Almost there” step before results. Optional `window.CRM_CALC_SUBMIT_ENDPOINT` for JSON POST; otherwise `console.info` stub. Skip link for internal QA.
- **Analytics**: Default `window.crmcalcTrack(event, payload)` no-op with `/* CONFIGURE */` comment; events `email_submit`, `results_view`, `gate_skip`.

## Question bank v2 (research-backed)

- **Status:** Shipped in repo — **15** audit questions (was 20), five categories × three items each; max raw score **75**; grades and “revenue at risk” use **the same percentage cutoffs** as the old 0–100 scale.
- **Spec:** [`docs/2026-05-13-crm-audit-question-research.md`](docs/2026-05-13-crm-audit-question-research.md) (Exa-backed rationale, coverage matrix, scoring).
- **Implementation plan:** [`docs/superpowers/plans/2026-05-13-crm-audit-question-bank-v2.md`](docs/superpowers/plans/2026-05-13-crm-audit-question-bank-v2.md).
- **Share links:** New copies use `#v=2&d=…` with `v: 2` in the JSON payload. **`#v=1&d=…` links with 20 answers remain valid** for restore.

## Follow-ups (outside this repo)

- **okaybabe.co**: Add a route (e.g. under `src/app/tools/…`) that hosts an iframe pointing at the deployed calculator URL, implements the resize listener, and aligns CSP (`frame-ancestors` / marketing site `frame-src`). **No change** to okaybabe.co in this commit.
- **Lead capture**: Wire `CRM_CALC_SUBMIT_ENDPOINT` to a server action or API route (e.g. Resend) using secrets in hosting env only — not in this static repo.
