# CRM Health Audit + Pipeline Calculator

Interactive **okaybabe** marketing tool: a twenty-question CRM health audit (five categories), weighted scoring, a pipeline value calculator with benchmarks, and a results view with category breakdowns and prioritized actions. Everything ships as a single static **`index.html`** (inline CSS and JS).

Design tokens mirror the Okay-Babe design system (`colors_and_type.css`): **Warm Zinc** in `:root` and **Obsidian Amethyst** on `html.dark`. All colors use **HSL triplets** consumed as `hsl(var(--token))`. Semantic **chart** aliases (`--chart-score-high` / `--chart-score-mid` / `--chart-score-low`) map to success / warning / destructive for category score bars. Grade pills use **`--success-foreground`**, **`--warning-foreground`**, and **`--destructive-foreground`** on tint backgrounds so text meets **WCAG AA** in both themes.

### Theme

- **System** (default): follows **`prefers-color-scheme`**.
- **Light** / **Dark**: forced modes, persisted in **`localStorage`** under **`crmcalc-theme`** (`light` | `dark` | `system`).
- Use the header **theme** control (cycles system → light → dark). `html` uses **`color-scheme: light dark`** for native form controls.

### Accessibility (brief)

- **Landmarks**: `<header>` (brand + theme), `<main>` for the wizard.
- **Progress**: the step indicator is a **`role="progressbar"`** with `aria-valuenow` / `aria-valuemax` / `aria-valuetext` updated from script.
- **Results**: an **`aria-live="polite"`** region announces score, grade, and a one-line summary when results render.
- **Forms**: calculator fields pair **`label for`** with **`input id`**; focus rings use **`:focus-visible`**.
- **Motion**: animations and width/color transitions on the progress bar, category bars, and score ring are reduced when **`prefers-reduced-motion: reduce`** is set.

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

## Fonts

The page loads **`fonts/*.woff2`** (paths are relative to `index.html`), then falls back to **`local()`** if a file is missing.

- **JetBrains Mono** (`fonts/jetbrains-mono-regular.woff2`) is OFL-licensed and **committed** in this repo.
- **Klim Slate A** — **National 2** (display, headings ≥20px) and **Söhne** (body; CSS `font-family: 'Soehne'` matches the hosted `.woff2` files). File names: `national-2-*.woff2`, `soehne-*.woff2`. Those Klim files are **gitignored** for public remotes; copy them from your licensed bundle into this repo’s `fonts/` directory. Follow your Klim order terms for pageviews, MAU, and paid-media restrictions.

If the Klim files are absent, the CSS falls back to installed desktop fonts, then `system-ui`.

## Repository

Remote: `https://github.com/prettycolor/crmcalculator.git`
