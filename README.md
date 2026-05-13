# CRM Health Audit + Pipeline Calculator

Interactive **okaybabe** marketing tool: a twenty-question CRM health audit (five categories), weighted scoring, a pipeline value calculator with benchmarks, and a results view with category breakdowns and prioritized actions. Everything ships as a single static **`index.html`** (inline CSS and JS).

Design tokens follow the Okay-Babe **Warm Zinc** light palette (canonical `colors_and_type.css` :root HSL triplets → hex in `index.html`): brand purple, zinc neutrals, and semantic status colors.

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
