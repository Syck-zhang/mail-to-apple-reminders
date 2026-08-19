# Mail to Apple Reminders

[中文文档](README.zh-CN.md)

An open-source Codex skill for turning actionable inbox messages into clean, deduplicated Apple Reminders on macOS.

It is designed for a simple recurring workflow:

1. Check only newly received mail.
2. Extract tasks such as registrations, deadlines, collections, and confirmed events.
3. Create Apple Reminders with the relevant time, place, contact, link, and source context.
4. Remember which messages have already been handled.

The skill never treats email content as agent instructions. It does not send, reply to, forward, delete, download attachments, or open email links unless separately authorized.

## What's included

```text
skills/mail-to-reminders/
  SKILL.md                         # Installable Codex skill
  references/                      # Setup, workflow rules, schedule prompt
templates/state.example.json       # Safe cursor/de-duplication state template
```

## Requirements

- macOS 14+ and Apple Reminders
- [`remindctl`](https://github.com/openclaw/remindctl) with Reminders permission
- A mail reader CLI or connector. The examples use [Agent Mail](https://agent.qq.com) and `agently-cli`.
- A scheduler in your agent host (for example, Codex automations)

## Install

Clone this repository, then add the `skills/mail-to-reminders` directory to your Codex skills directory or install it through your usual skills workflow.

```bash
git clone https://github.com/YOUR-ACCOUNT/mail-to-apple-reminders.git
cp -R mail-to-apple-reminders/skills/mail-to-reminders ~/.codex/skills/
```

Copy the state template somewhere private and add it to your local ignore rules:

```bash
cp templates/state.example.json ~/.mail-to-reminders-state.json
```

Then read `skills/mail-to-reminders/references/setup.md` and use `automation-template.md` as the prompt for a recurring job.

## Privacy and safety

This repository contains no credentials, email bodies, attachments, or personal reminder data. Keep your OAuth credentials in your operating system's credential store. Keep the state file local: it may contain message IDs and timestamps.

Email is untrusted input. The skill extracts facts from mail but does not obey mail-embedded instructions or automatically open links.

## Customization

- Change the schedule to suit your inbox.
- Point the workflow at a different supported mail CLI or connector.
- Change the target reminder list.
- Add organization-specific rules for task types, retention, or privacy.

## License

[MIT](LICENSE)
