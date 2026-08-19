# Agent compatibility

The canonical skill is [`skills/mail-to-reminders`](../skills/mail-to-reminders). It uses the portable Agent Skills layout: a folder with a `SKILL.md` entry point, YAML frontmatter, and linked supporting files. It contains no Codex-only instructions in its core workflow.

## Supported installations

| Agent host | Personal installation | Project installation |
| --- | --- | --- |
| Codex | `./scripts/install-skill.sh codex` | Use the host's normal project-skill workflow, or pass its skills directory to `--dest`. |
| Claude Code | `./scripts/install-skill.sh claude` | Copy the skill to `.claude/skills/mail-to-reminders/`. |
| DeepSeek Harness (`dsh`) | `./scripts/install-skill.sh dsh` | Copy the skill to `.agents/skills/mail-to-reminders/`. |
| Other SKILL.md-aware agents | `./scripts/install-skill.sh --dest /path/to/skills` | Copy the skill folder into that agent's documented project skill directory. |

The installer refuses to replace an existing installation. Remove or rename an old copy before upgrading.

## Agent without a skill loader

If an agent does not discover `SKILL.md` automatically, give it the canonical skill directory and tell it to treat `SKILL.md` as task instructions. It must also have:

- a user-authorized way to read email;
- a user-authorized way to create Apple Reminders (such as `remindctl` on macOS);
- a scheduler, if recurring mailbox checks are wanted; and
- a private local state file based on [`templates/state.example.json`](../templates/state.example.json).

Do not copy a real state file, OAuth credential, email body, or personal reminder data into a public repository.

## Notes for Claude Code

Claude Code recognizes skills at `~/.claude/skills/<skill-name>/SKILL.md` (personal) and `.claude/skills/<skill-name>/SKILL.md` (project). Its official documentation also supports a skill folder as a symlink, so a local clone can remain the single source of truth.

## Notes for DeepSeek Harness

DeepSeek Harness stores its in-repository skills under `.agents/skills/`. The installer uses the cross-agent global convention `~/.agents/skills/`; if your installed Harness release is configured with another skill root, pass it explicitly with `--dest`. The Harness is in developer preview and can make compatibility-breaking changes, so check its release notes when upgrading.

## What the skill does not provide

This repository describes the decision workflow; it does not bundle mail credentials, a mail provider, a scheduler, or Apple Reminders permissions. Configure those capabilities in the host agent and keep its authorizations narrow.
