---
name: rea-curation
description: Curate and expand the awesome-rea repository. Use when adding AI-assisted reverse engineering projects (decompilation, static recompilation, native ports, agent tooling), collecting practice signals from X/Reddit/HN/blogs, refreshing README counts, or running periodic evidence sweeps.
---

# REA Curation

Use this skill to maintain `awesome-rea` as a **strict list of AI-assisted reverse engineering work, where every entry states how correctness is decided**.

## The rule that defines this list

**Every category entry has to state the acceptance test.** Not what the project is about, not what the model did — what decides whether the work is correct: a byte comparison against the original ROM, a required hash match on the user's own dump, a compatibility matrix, a source review gate, a build that has to stay green.

A project that cannot say how correctness is decided does not go on a category page, however impressive its demo.

**But it does not get dropped — it goes into `categories/related-practices-discussions.md`, and that is a first-class outcome, not a waiting room.** The list runs on two tracks:

1. **Projects** (the category pages) — need the acceptance test.
2. **Practice signals** (`related-practices-discussions.md`) — need a public claim someone made about the work, and **neither a repository nor an acceptance test**. A post-mortem, a talk write-up, a thread where practitioners disagree.

Many of the most useful things in this field never become a repository. A subject is worth recording while it is still being argued about, so **do not let the verification rule quietly delete discussion leads.** If someone publicly asks why AI decompilation is not solved yet, or a porting community trades notes on where agents help, that is a discussion entry. The only things to keep out are excitement with no claim about the work, and vendor announcements.

This is the difference between this list and "AI is impressive" collections. Protect it.

## Source of truth

Read these before making changes:

- `README.md`
- `CONTRIBUTING.md`
- every file under `categories/`

`README.md` is a **build artefact**, never the editing surface. Edit `categories/*.md`, then run `python3 scripts/build-readme.py`. The prose sections that are not tables (inclusion criteria, the not-an-endorsement block, the legal notes) live in `scripts/build-readme.py`, so change them there.

The category list and which files are still being seeded live in `CATEGORIES` and `OPEN_TRACKING` in `scripts/build-readme.py`. Read them there rather than from a copy that goes stale.

## Hard inclusion rules

All of these must hold:

- **Public and citable** — a reachable repository, write-up or public thread. Not a paywall, not a login wall, not a dead link.
- **AI or LLM agents did identifiable work** — an agent wrote functions, hunted root causes, wrote tests, ran verification, or played a verifier role. Generic reverse engineering with no agent in the loop is **out of scope**, even at 273 stars.
- **The acceptance test is stated** — required on **Track 1 only**. Track 2 does not need one. **One category per entry**, chosen by what the project *is*, not who made it.

Reject outright:

- ROMs, original game assets, and asset dumps. This list links to clean-room reimplementations and ports only. An archive of extracted game data is out of scope however it is framed, and the legal notes in `build-readme.py` say so explicitly — keep it that way.
- Vendor announcements, marketing copy where "AI-powered" replaces a description of work.
- Opinion pieces with no public artifact behind them.
- Sources that need an account to read.

**The rule has teeth and it has already bitten.** `TheOnlyZac/sly1` (273★) and `theclub654/ProjectCane` (245★) are real, popular projects that were declined because neither README mentions AI at all — a second-hand claim that AI acted as a learning partner could not be checked against either repository. Being willing to drop two high-star projects is what makes the list worth reading.

## Entry-writing rules

Format, exactly one line and one sentence:

```md
- [Name](URL) - Domain: what the agents actually do, and what accepts the result.
```

- **Domain** is the short prefix matching the category: `Decompilation:`, `Native port:`, `Static recompilation:`, `Tooling:`, `Verification tooling:`, `Methodology:`, `Post-mortem:`, `X thread:`.
- **Name the mechanism, not the outcome.** "Verified by byte comparison against the original ROM" is good. "Verified to be accurate" is not.
- **Include the number when the source provides one** — 99% of functions with 83% byte-exact, 11,385 of 11,389 matched, 3,669 of 7,645 in a week.
- **Never write a star count into an entry.** `build-readme.py` derives star badges from the link at render time, so a baked-in number would drift.
- No hype.

### Do not invent URLs

**Verify every link yourself before it lands, and never reconstruct a URL from memory or from a truncated reading.** In this repository's first round, three entries were written with plausible-looking URLs that had never been checked; two did not exist and one pointed at the wrong post. The fix is not better guessing, it is a rule: if the link cannot be reached, the entry does not go in, and the lead is reported as unverified so the maintainer can supply it.

Corollary: **a failed lookup is not proof of absence, and the first query is not a test.** Both halves of that have already cost this list entries.

- A Cloudflare-blocked page looked unreachable to `curl`, so a whole entry was parked as unverifiable. Fetching it with a browser-fingerprinted tool returned the full text, and the article turned out to have been **updated specifically to add Jev's benchmark numbers** — the strongest evidence of the round was in the source I had declared unavailable.
- `gh search repos "mario kart wii recomp"` returned nothing, so a 1021-upvote story was written off as having no repository. Dropping the word `recomp` and searching `"mario kart wii"` found a **664★** project whose README carries a full AI disclosure.

So the order is: **change the query, then change the retrieval method, and only then conclude.** Report a source as *unverified*, never as *non-existent*, and say which method failed.

### One project, one category

If a project spans two — a matching decompilation that also ships a PC port — pick the one that describes what it primarily is and mention the second thing inside that entry. `build-readme.py` refuses to write the README when two categories claim the same source, and that check has already caught the maintainer.

### Rate limit

**At most three entries per author in a single review pass.** Extras queue to the next pass, in submission order — never by quality, and never promoted ahead of an older queued item for having more stars. `blog.chrislewis.au` has eight posts in one series; three per round keeps any single voice from dominating the discussions page.

## Category model

Main categories for stronger evidence (public repos, project pages, substantial write-ups):

- `game-decompilation.md` — matching decompilation, counter is functions matched and byte-exact
- `static-recompilation-native-ports.md` — static recompilation and ports, check is behavioural
- `tooling-and-mcp.md` — MCP servers, verification helpers, agent collaboration layers
- `console-and-firmware.md` — non-game reversing. **OPEN_TRACKING**: stays off the front page until something qualifies.

`categories/related-practices-discussions.md` for credible practice signals — post-mortems, methodology write-ups, X threads — including arguments whose value is in the disagreement rather than in an artifact.

## Verified forensic commands

These are known to work on this machine, in this order of usefulness.

### GitHub — new projects and new citations

```bash
gh search repos "decompilation AI agents" --limit 25 --json fullName,stargazersCount,description
gh search repos "static recompilation" --created ">2026-10-01" --limit 30 --json fullName,stargazersCount,description
gh search code '"claude" decompilation' --limit 20 --json repository,path
gh search code 'matching decompilation' --limit 20 --json repository,path
```

Search by **artifact, not by name**: `gh search code 'byte matching harness'`, `gh search code 'decomp agent'`. A port rarely says "AI" in its description.

### X / Twitter — practice signals

`agent_twitter`, or the `twitter` CLI with yaml output parsed by python3:

```bash
twitter user-posts arpit_bhayani -n 5 -o /tmp/x.yaml
python3 -c "import yaml;d=yaml.safe_load(open('/tmp/x.yaml'));items=d if isinstance(d,list) else (d.get('tweets') or (d or {}).get('results') or []);print('\n'.join('https://x.com/u/status/'+str(t.get('id') or t.get('id_str')) for t in items))"
twitter search "AI decompilation" -n 25
```

Worth following: **@mdaman010**, **@arpit_bhayani**, **@AIWarper**, **@momo5502**, and the `#matchingdecomp` / `#recomp` crowd.

### Reddit

```bash
rdt search "AI decompilation" --limit 10 --json
rdt read 1x1pgyo            # read a thread by id
```

Priority subs: **r/emulation**, **r/ReverseEngineering**, plus r/gamedev and r/programming for the arguments. `rdt search` returns JSON; `rdt read` takes a post id. Note that `.json` endpoints on reddit.com return 403 and old.reddit redirects to a login — `rdt` is the reliable path.

### Hacker News

```bash
curl -s -o /tmp/hn.json "https://hn.algolia.com/api/v1/search?query=decompilation+AI&hitsPerPage=20"
python3 -c "import json;d=json.load(open('/tmp/hn.json'));[print(h['title'],'|',h.get('url'),'| https://news.ycombinator.com/item?id='+h['objectID']) for h in d['hits'][:10]]"
```

**Always write to a file and parse — never print the response to stdout.** Show HN posts are where single-purpose tools surface.

### Progress trackers — the numbers that matter here

- **decomp.dev** — per-project function-level progress for matching decompilations; the fastest way to check a project's current counter instead of trusting a write-up from months ago. Counters move: `sm64ds-decomp` read 11,377 / 11,389 in an October report and 11,385 / 11,389 in the repository itself.
- Repository **progress badges** and `<!-- progress:start -->` blocks in READMEs.
- **CHANGELOG.md** and `porting-notes.md` files — the latter is itself an acceptance mechanism when it requires every recurring bug class to be written back.

### Blogs and long-form

- `momo5502.com/posts/` — feed at `momo5502.com/index.xml`; the 2026-10-09 decompilation post is the reference account.
- `blog.chrislewis.au/` — a series on LLM-assisted N64 decompilation; feed at `blog.chrislewis.au/index.xml`.
- `scientia.godsibb.net` — a Discourse forum; `search.json?q=...` works without an account, which is how the Xenosaga thread was found.
- Vendor and personal blogs for the write-ups that never reach GitHub. Fetch them with a browser fingerprint (`web_fetch`, or `curl` with `HTTPS_PROXY=http://127.0.0.1:7897` — the local proxy is required, TUN mode sets no system proxy).

### Languages

English dominates. Chinese and Japanese leads are few but worth one pass each:

- `AI 反编译`, `AI 逆向`, `移植 AI`
- `AI リバースエンジニアリング`, `AI 移植`

Do not filter by star count. This list has admitted 0★ verification tooling because the tool was the missing checker, and refused 273★ projects because no AI work was stated.

## Periodic maintenance loop

When invoked for a recurring sweep:

1. Read the current category files and the README coverage table.
2. Search 3–10 new public leads across the channels above.
3. **Verify every link and every number against the source.** Check counters live rather than from a report.
4. Filter hard. Report what was rejected and why, including leads that were merely unverifiable.
5. Add entries, one sentence each, one category each, ≤3 per author.
6. Refresh counts and README:
   ```bash
   python3 scripts/build-readme.py
   ./scripts/commit-and-push.sh
   ```
   The generator prints `README.md written: N entries across M categories` and refuses to write on a duplicate source. `commit-and-push.sh` refuses a dirty tree by design — the build is run first via `REBUILD_README=1` when needed.
7. If `console-and-firmware` gets its first qualifying entry, move it from `OPEN_TRACKING` to `CATEGORIES` in `build-readme.py` so it enters the front page.
8. **Post once, only if there are new entries.** No new entries means no post — that is the project convention.
9. Summarize: new entries, promoted entries, rejections with reasons, and the post link.

## Posting

> **2026-10-18 起：本列表的 sweep 不再自己发帖。** 三个列表的更新每天合成**一条**合并帖，
> 由独立的 `curation-digest-post` 任务发出。所以每轮结束时把结果追加到
> `~/.agent-reach/state/curation-digest.md` 的 `## <本仓库名>` 段（总数 + 每条新增一句话 +
> 一两条最值得说的未采纳原因）；**无新增就什么都不写**。格式与示例见
> /skill:tweet-posting-cdp 的「跨列表合并帖」一节。

Use the same CDP path as the sibling lists, and read `/skill:tweet-posting-cdp` for the full usage:

```bash
CDP_PORT=9333 ~/.agent-reach/scripts/post-tweet-cdp.mjs < /tmp/rea_post.txt
```

Hard rules:

- **Call it exactly once per round.** No re-posting in different wording or another language, before or after. Violating this fails the round.
- The post is **Chinese**, covers every new entry in one line each (what it is + why it earned a place), and ends with `github.com/yibie/awesome-rea` and the current total.
- Verify first if unsure: `DRY_RUN=1` prints `内容校验通过：N 字符 / M 段落`.
- If the CDP port is dead, do **not** retry: print the text for manual posting and say so. Chrome refusing to answer on 9333/9222/9223 with no process running means the browser is simply down; the repair is `~/.agent-reach/scripts/ensure-chrome.sh`.
- A post that never reached the composer is not a duplicate risk. If a previous round's post failed to send, folding its entries into the next round's single post is the faithful reading of "post once" — but do not re-send text that was actually published.

## Quality bar

**The verification clause is the entry.** An impressive project with no stated acceptance test is a rejection with a good reason, and the rejection belongs in the round summary. A 0★ tool that supplies a missing independent checker is an acceptance.

Keep this list small and defensible. It is more useful as seventeen entries that all answer "how do you know it's correct?" than as two hundred that answer "isn't AI amazing?".
