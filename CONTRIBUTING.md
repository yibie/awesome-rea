# Contributing

Thanks for adding to the list. Read the two rules below before opening a pull request — most submissions that get sent back are sent back for one of them.

## The one rule that matters

**Every entry has to state the acceptance test.**

Not what the project is about. Not what the model did. What decides whether the work is correct: a byte comparison against the original ROM, a required hash match on the user's own dump, a compatibility matrix, a build that has to stay green.

This is the entire point of the list. A project that cannot say how correctness is decided does not go in a project category, no matter how good the demo looked.

**It goes in `categories/related-practices-discussions.md` instead, and that is a normal outcome rather than a rejection.** That category is a first-class track, not a waiting room: it needs **no public repository and no acceptance test**, only a public claim someone made about the work. A post-mortem, a talk write-up or a thread where practitioners disagree all belong there.

## Entry format

One line, one sentence, exactly one category:

```md
- [Name](https://example.com) - Domain: what the AI agents actually do, and what accepts the result.
```

- **Name** links to the primary public source — a repository, a write-up, a public thread. Not a paywall, not a login wall, not a dead link.
- **Domain** is the short prefix, matching the category (`Decompilation:`, `Native port:`, `Tooling:`, `Static recompilation:`).
- **The verification clause is mandatory** and should name the mechanism, not the outcome. "Verified by byte comparison against the original ROM" is good. "Verified to be accurate" is not.

Do not write a star count into an entry. Star badges are generated from the link at build time by `scripts/build-readme.py`, so a number in the text would drift away from reality.

## Which category

By what the project **is**, not by who made it or what it runs on.

| Category | For |
| --- | --- |
| `game-decompilation.md` | Matching decompilation, where the counter is functions matched and byte-exact |
| `static-recompilation-native-ports.md` | Static recompilation and native ports, where the check is behavioural |
| `tooling-and-mcp.md` | MCP servers, verification helpers, agent collaboration layers |
| `related-practices-discussions.md` | Credible public practice signals, methodology post-mortems, arguments |
| `console-and-firmware.md` | Non-game reversing. Tracked but empty until something qualifies |

One entry, one category. If a project spans two, pick the one that describes what it primarily is.

## Sending it

1. Edit the file in `categories/` — **never edit `README.md` directly**. It is generated, and your change there will be overwritten by the next build.
2. Run `python3 scripts/build-readme.py`. It will refuse to write if your entry duplicates a source already in the list.
3. Open the pull request with the entry and the regenerated README.

## What gets declined

- Vendor announcements and marketing copy where the "AI" claim is not a description of work.
- Opinion pieces with no public artifact behind them.
- Sources that cannot be reached without an account.
- Bulk drops: several repositories by one author published the same day, sharing a README template, a scaffold or a single-commit history, are usually one project family. They count as one submission, and the list counts them once.

## Legal and ethics

By contributing, you confirm the link is public and that describing what a project does is not the same as recommending it. Native ports must not include original assets, and this list does not host or link to ROMs or decompiled asset dumps. See the Legal & ethics notes in the README before adding anything that involves redistributing game data.
