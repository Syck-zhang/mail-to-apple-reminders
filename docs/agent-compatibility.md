# Install in Codex or Claude Code

The canonical skill lives in [`skills/mail-to-reminders`](../skills/mail-to-reminders). Install the entire folder: its linked references are part of the workflow.

## Choose an installation method

| Host | Recommended | Alternative |
| --- | --- | --- |
| Codex | Send it the [Codex setup prompt](../skills/mail-to-reminders/references/one-prompt-setup.md). | Run `./scripts/install-skill.sh codex`. |
| Claude Code | Run `./scripts/install-skill.sh claude`. | Copy the folder to `.claude/skills/mail-to-reminders/` for one project. |

To install to a nonstandard Codex or Claude Code skills directory, use:

```bash
./scripts/install-skill.sh --dest /path/to/skills
```

The installer refuses to overwrite an existing skill. Remove or rename the old copy before upgrading.

## Scheduling differences

Codex can create a recurring automation inside the current task. Claude Code can run the same workflow, but a recurring run needs an external scheduler (for example, a user-managed system scheduler). The [setup prompts](../skills/mail-to-reminders/references/one-prompt-setup.md) make this distinction explicit.

## Notes for Claude Code

Claude Code recognizes skills at `~/.claude/skills/<skill-name>/SKILL.md` (personal) and `.claude/skills/<skill-name>/SKILL.md` (project). Its official documentation also supports a skill folder as a symlink, so a local clone can remain the single source of truth.

## Boundaries

This repository describes the decision workflow; it does not bundle mail credentials, a mail provider, a scheduler, or Apple Reminders permissions. Configure those capabilities in Codex or Claude Code and keep authorizations narrow.
