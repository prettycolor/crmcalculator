# CRM Health Audit + Pipeline Calculator

Interactive **okaybabe** marketing tool: a **15-question** CRM health audit (five categories × three signals each), weighted scoring (max **75** raw points; grades use the same **percentage bands** as the prior 0–100 scale), a pipeline value calculator with benchmarks, and a results view with category breakdowns and prioritized actions. Everything ships as a single static **`index.html`** (inline CSS and JS). Research rationale and the 20→15 merge matrix live in **`docs/2026-05-13-crm-audit-question-research.md`**.

Design tokens mirror the Okay-Babe design system (`colors_and_type.css`): **Warm Zinc** in `:root` and **Obsidian Amethyst** on `html.dark`. All colors use **HSL triplets** consumed as `hsl(var(--token))`. Semantic **chart** aliases (`--chart-score-high` / `--chart-score-mid` / `--chart-score-low`) map to success / warning / destructive for category score bars. Grade pills use **`--success-foreground`**, **`--warning-foreground`**, and **`--destructive-foreground`** on tint backgrounds so text meets **WCAG AA** in both themes.

### Theme

- **System** (default): follows **`prefers-color-scheme`**.
- **Light** / **Dark**: forced modes, persisted in **`localStorage`** under **`crmcalc-theme`** (`light` | `dark` | `system`).
- Use the header **theme** control: each click **toggles** between **light** and **dark** appearance (one click always flips the page). The first visit can still follow the device (**system**) from storage or `?theme=system`; the button does not cycle back into `system` (that step used to match the OS and look like a no-op). `html` uses **`color-scheme: light dark`** for native form controls.

### Accessibility (brief)

- **Landmarks**: `<header>` (brand + theme), `<main>` for the wizard.
- **Progress**: the step indicator is a **`role="progressbar"`** with `aria-valuenow` / `aria-valuemax` / `aria-valuetext` updated from script.
- **Results**: an **`aria-live="polite"`** region announces score, grade, and a one-line summary when results render. The first results card includes a **“How this score works”** section (scoring rules, grade bands, pipeline vs audit) plus an expandable **privacy / data** note (browser-only scoring, resume link in URL fragment, optional `?gate=1` POST).
- **Forms**: calculator fields pair **`label for`** with **`input id`**; focus rings use **`:focus-visible`**.
- **Motion**: animations and width/color transitions on the progress bar, category bars, and score ring are reduced when **`prefers-reduced-motion: reduce`** is set.

### Phase 2 polish

- **Icons**: checklist, benchmark, and pipeline warning use **inline SVG** with `currentColor` / theme tokens (no emoji), with `aria-hidden="true"` where the adjacent text carries the meaning.
- **Print**: **`@media print`** forces a light, toner-friendly page (white background, dark text), hides the theme toggle, progress bar, resume prompt, and share footer, avoids awkward breaks inside score/action cards, and skips the beta CTA strip. Category bars request **`print-color-adjust: exact`** so the chart colors survive printing when supported.
- **Shareable state (hash only)**: After you have progress, **Copy link to resume later** encodes answers + calculator field values in the **URL fragment** as `#v=2&d=<base64url(JSON)>` (payload field **`v`: 2**), not query parameters (reduces accidental referrer leakage). **Legacy `#v=1&d=…` links with 20 answers still restore.** **No server** — anyone with the link can read the payload. **Do not share sensitive answers** in links. Opening a link with a valid hash shows a **“Resume saved progress?”** prompt in the **footer** (Resume / Dismiss). Append **`?restore=1`** to the URL to **restore immediately** without the prompt (useful for bookmarks). Dismiss clears the hash from the address bar. Saved state can include mode **`gate`** when **`?gate=1`** was used; restoring a gate snapshot requires the same query flag.

### Phase 3 — embed, email gate, analytics hook

**Query flags**

| Param | Values | Purpose |
|-------|--------|---------|
| `embed` | `1` or `true` | Minimal chrome (`html.embed`, header hidden). Enables `postMessage` resize pings to parent. |
| `theme` | `dark` \| `light` \| `system` | Overrides `localStorage` theme for this load (iframe-friendly when `prefers-color-scheme` is wrong). Hides the header theme toggle when set. |
| `gate` | `1` | Enables the **Almost there** email + team-size step after the pipeline form and before results. **Off by default** so existing share links behave the same. |

**Parent page: iframe + auto height**

The calculator sends `postMessage` to `parent` (only when `embed=1`):

```json
{ "type": "crmcalc-resize", "height": 1234 }
```

- Fires on load, on step changes, and on window resize (**debounced ~100ms**).
- Height is `Math.ceil(document.documentElement.scrollHeight)`.

Example host page (vanilla JS):

```html
<iframe id="crmcalc" title="CRM Health Audit" src="https://YOUR_HOST/index.html?embed=1&theme=system" style="width:100%;border:0;display:block"></iframe>
<script>
window.addEventListener('message', function (e) {
  var d = e.data;
  if (!d || d.type !== 'crmcalc-resize' || typeof d.height !== 'number') return;
  // Optional: verify e.origin === 'https://YOUR_HOST'
  var el = document.getElementById('crmcalc');
  if (el) el.style.height = d.height + 'px';
});
</script>
```

**CSP / framing**

- **Calculator origin**: Serve with a restrictive `Content-Security-Policy` as needed; for embedding on okaybabe.co you may use `Content-Security-Policy: frame-ancestors https://okaybabe.co https://www.okaybabe.co` (adjust hosts).
- **Marketing site**: Allow the calculator origin in `frame-src` (or default-src) so the iframe loads.

**Email gate + lead POST (no secrets in repo)**

- With **`?gate=1`**, users see **Almost there** (required email, required team-size band) before results. Data is stored in **`sessionStorage`** (`crmcalc-gate-lead`, `crmcalc-gate-done`) for the tab session; **not** embedded in the URL hash (PII stays out of shared links).
- **Skip (internal testing)** bypasses validation and still shows results.
- Optional: set **`window.CRM_CALC_SUBMIT_ENDPOINT`** (string URL) before or after load. On successful validation, the app `POST`s JSON: `{ email, teamSize, calc, scoreTotal, source: 'crm-calculator' }`. If unset, the app logs a **`console.info`** stub and continues (demo/offline safe).
- Production wiring belongs in your host app or API (e.g. Resend, server action): keep API keys only in server environment variables.

**Analytics placeholder**

- The page defines **`window.crmcalcTrack(event, payload)`** if missing — default body is a **`/* CONFIGURE */`** no-op (no network).
- Called with **`email_submit`** (payload avoids raw email in the hook; use server endpoint for PII), **`results_view`** (`scoreTotal`, `gradeBand`), and **`gate_skip`**.

## Run locally

Open the file in a browser:

```bash
open index.html
```

Or serve the folder with any static server (optional, for strict module/CORS testing):

```bash
python3 -m http.server 8080
```

Then visit `http://localhost:8080`.

### Verify (local + CI)

Static checks (question count, no stale 22-step progress copy in `index.html`, no “20 question” UI copy in key files):

```bash
chmod +x scripts/verify.sh   # once
./scripts/verify.sh
```

GitHub Actions runs the same script on push and pull requests to `main` (see `.github/workflows/verify.yml`).

## Fonts

The page loads **`fonts/*.woff2`** (paths are relative to `index.html`), then falls back to **`local()`** if a file is missing.

- **JetBrains Mono** (`fonts/jetbrains-mono-regular.woff2`) is OFL-licensed and **committed** in this repo.
- **Klim Slate A** — **National 2** (display, headings ≥20px) and **Söhne** (body; CSS `font-family: 'Soehne'` matches the hosted `.woff2` files). File names: `national-2-*.woff2`, `soehne-*.woff2`. Those Klim files are **gitignored** for public remotes; copy them from your licensed bundle into this repo’s `fonts/` directory. Follow your Klim order terms for pageviews, MAU, and paid-media restrictions.

If the Klim files are absent, the CSS falls back to installed desktop fonts, then `system-ui`.

## Repository

Remote: `https://github.com/prettycolor/crmcalculator.git`
