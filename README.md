# CRM Health Audit + Pipeline Calculator

Interactive **okaybabe** marketing tool: a twenty-question CRM health audit (five categories), weighted scoring, a pipeline value calculator with benchmarks, and a results view with category breakdowns and prioritized actions. Everything ships as a single static **`index.html`** (inline CSS and JS).

Design tokens follow the Okay-Babe wiki **Ref-Design-Tokens** (Warm Zinc light mode): brand purple, zinc neutrals, and status colors documented in the page stylesheet.

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

Headings and body use **Soehne** and **National 2** via `@font-face` with `local()` lookups; **JetBrains Mono** is used for metrics. They render as intended when those fonts are installed locally. For production on okaybabe.co, plan to self-host `woff2` files next to this page (or serve them from your asset CDN) and extend `@font-face` with `url(...)` sources.

## Repository

Remote: `https://github.com/prettycolor/crmcalculator.git`
