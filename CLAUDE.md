# CLAUDE.md

Guidance for Claude Code when working in the nxthdr blog (Hugo site).

## Writing style

- **No em-dashes (`—`) or en-dashes (`–`).** Use commas, colons, parentheses, or separate sentences instead. This applies to all post content.
- Match the voice of existing posts in `content/`: first-person plural ("we"), narrative seasonal updates with `##` section headings.
- Keep links concrete and prefer linking project names to their repos/docs.

## Structure

- Posts live under `content/YYYY/MM/<slug>.md`.
- Seasonal updates use front matter: `title`, `date` (`YYYY-MM-DD`), the `authors` block, and tags `update` + `season`.
- Put a `<!--more-->` after the intro paragraph to mark the summary cutoff.

## Local preview

- `hugo server` (theme is the `m10c` git submodule under `themes/`).
- Local URLs drop the production `/blog` prefix, e.g. `http://localhost:1313/2026/06/spring-update/`.
