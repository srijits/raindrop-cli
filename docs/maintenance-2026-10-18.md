# Reviewed CLI/MCP maintenance — 2026-10-18

Execution issue: https://github.com/srijits/raindrop-cli/issues/1 .
SOCHSE owner: `sch-infra-printed-cli-upgrades`.

Updated from public Printing Press release `2026.9.1`, library source pinned to
`a09fb04aee97081e58c9550b672989c2e7ab8e79`. Normalized import paths and formatting
before comparison: only six existing source/dependency files changed. The custom
duplicate-apply preservation and full-sync reconciliation implementations remain
unchanged, and all local workflow files/patch ledgers remain present.

Changes include the enetx/http1.0.29 dependency, fail-closed handling of ambiguous
writes even with a caller-supplied idempotency key, bounded recovery from explicit
429 rejection, and truthful zero committed-row progress after transaction rollback.
Imported the upstream release ledger/version stamps rather than inventing a release.

Delivered source revision: `68180dd02a3b97c96d603503ab5d8b44ba92a8ea`.
Built with Go1.26.9. The unrelated existing AGENTS.md change/scratch files remain
outside this commit; Go's dirty-worktree marker is therefore not a clean-source
attestation. Exact replacement hashes are:

- `bin/raindrop`: `a0137b2db2e551ebb8fdcfb0eac26e28b26a96b577a2c4f402d1230df8862bc0`
- `bin/raindrop-pp-mcp`: `c1ad06eeb14fc32f25269e0a050548e835a90b0c539453f5cdbacb045b4c5acc`

The complete Go suite passed (13 tested packages), plus the new synthetic TLS
regression proving keyed502 writes execute once while explicit429 rejection can
retry. The exact CLI performed an offline search on a consistent private store
copy; schema version9, schema hash and all52 table counts remained unchanged.
The exact MCP server completed stdio initialize and reported2026.9.1. No MCP tool,
remote write, sync, model call or schema migration was exercised. No new binary
opened the live store. Both binaries were atomically replaced; no prior MCP
process was running at the time.

Private consistent SQLite, old binary and config rollback artifacts remain under
`/var/backups/sochse-weekly/2026-10-18-printed-clis/laptop/`. Sanitized receipts and
build/test logs belong to SOCHSE's gitignored
`.local/printed-cli-upgrades/2026-10-18/`; private test stores use its0700`private/`
directory. Source-to-artifact identity is recorded above; interactive remote-write
acceptance and public-library publishing were not run.

The repository has no initialized Beads database. The owning execution issue and
SOCHSE Bead cross-link the work; durable `metadata.work_desk` result/next action
lives in that SOCHSE Bead. Keep reusable code tracked, later-session generated
evidence gitignored and sanitized decisions durable. Preserve the patch ledgers
when regenerating; do not infer completion from a commit alone.
