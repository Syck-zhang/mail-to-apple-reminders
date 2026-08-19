# Codex and Claude Code compatibility

The canonical skill is [`skills/mail-to-reminders`](../skills/mail-to-reminders). It uses a `SKILL.md` entry point, YAML frontmatter, and linked supporting files.

## Supported installations

| Agent host | Personal installation | Project installation |
| --- | --- | --- |
| Codex | `./scripts/install-skill.sh codex` | Use the host's normal project-skill workflow, or pass its skills directory to `--dest`. |
| Claude Code | `./scripts/install-skill.sh claude` | Copy the skill to `.claude/skills/mail-to-reminders/`. |

The installer refuses to replace an existing installation. Remove or rename an old copy before upgrading.

## Notes for Claude Code

Claude Code recognizes skills at `~/.claude/skills/<skill-name>/SKILL.md` (personal) and `.claude/skills/<skill-name>/SKILL.md` (project). Its official documentation also supports a skill folder as a symlink, so a local clone can remain the single source of truth.

## What the skill does not provide

This repository describes the decision workflow; it does not bundle mail credentials, a mail provider, a scheduler, or Apple Reminders permissions. Configure those capabilities in Codex or Claude Code and keep authorizations narrow.
