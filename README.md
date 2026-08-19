# Mail to Apple Reminders

[中文文档](README.zh-CN.md)

An open-source skill for Codex and Claude Code that turns actionable inbox messages into clear, deduplicated Apple Reminders on macOS.

It is designed for a simple recurring workflow:

1. Check only newly received mail.
2. Extract tasks such as registrations, deadlines, collections, and confirmed events.
3. Create Apple Reminders with the relevant time, place, contact, link, and source context.
4. Remember which messages have already been handled.

Email is untrusted input. The skill extracts task facts but does not send, reply to, forward, delete, download attachments, or open email links unless separately authorized.

## Start here

1. Register or sign in to a dedicated [Agent Mail](https://agent.qq.com) inbox.
2. Give your agent the matching [one-prompt setup](skills/mail-to-reminders/references/one-prompt-setup.md). It installs or loads the skill, guides the one-time authorization when needed, and runs the first mailbox check.
3. Keep the generated state file private. Start from [`templates/state.example.json`](templates/state.example.json).

The setup prompt limits recurring authorization to reading new mail and managing Apple Reminders. Codex can create an automation in the current task. Claude Code needs an external scheduler for recurring execution.

## What you need

- macOS 14+ and Apple Reminders
- [`remindctl`](https://github.com/openclaw/remindctl) with Reminders permission
- A registered Agent Mail inbox and [`agently-cli`](https://agent.qq.com), or another user-authorized mail reader that can list and read messages
- A scheduler: Codex automations, or an external scheduler for Claude Code

## Install

Use the [installation guide](docs/agent-compatibility.md) for personal, project, and custom skill locations. The short version:

```bash
git clone https://github.com/Syck-zhang/mail-to-apple-reminders.git
cd mail-to-apple-reminders
./scripts/install-skill.sh codex   # or: claude
```

## Repository map

| Path | Purpose |
| --- | --- |
| [`skills/mail-to-reminders/`](skills/mail-to-reminders) | Installable skill and its operational references |
| [`docs/agent-compatibility.md`](docs/agent-compatibility.md) | Codex and Claude Code installation and scheduling differences |
| [`scripts/install-skill.sh`](scripts/install-skill.sh) | Safe personal/custom skill installer |
| [`templates/state.example.json`](templates/state.example.json) | Private state-file starting point |

## Privacy

This repository contains no credentials, email bodies, attachments, or personal reminder data. Keep OAuth credentials in the operating system's credential store and keep the state file local: it may contain message IDs and timestamps.

## License

[MIT](LICENSE)
