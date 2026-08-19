# Mail to Apple Reminders

[中文文档](README.zh-CN.md)

An open-source, cross-agent skill for turning actionable inbox messages into clean, deduplicated Apple Reminders on macOS.

It is designed for a simple recurring workflow:

1. Check only newly received mail.
2. Extract tasks such as registrations, deadlines, collections, and confirmed events.
3. Create Apple Reminders with the relevant time, place, contact, link, and source context.
4. Remember which messages have already been handled.

The skill never treats email content as agent instructions. It does not send, reply to, forward, delete, download attachments, or open email links unless separately authorized.

## What's included

```text
skills/mail-to-reminders/
  SKILL.md                         # Canonical portable skill
  references/                      # Setup, workflow rules, schedule prompt
scripts/install-skill.sh           # Installer for Codex, Claude Code, and dsh
docs/agent-compatibility.md        # Agent-specific installation paths
templates/state.example.json       # Safe cursor/de-duplication state template
```

## Requirements

- macOS 14+ and Apple Reminders
- [`remindctl`](https://github.com/openclaw/remindctl) with Reminders permission
- An agent mailbox and a mail reader CLI or connector. The examples use [Agent Mail](https://agent.qq.com) and `agently-cli`.
- A scheduler in your agent host (for example, Codex automations)

## Create and authorize an Agent Mail inbox

This workflow needs a mailbox that the agent may read. We recommend a dedicated [Agent Mail](https://agent.qq.com) inbox rather than granting an agent access to a personal inbox. You can replace it with another user-authorized mail connector if it supports listing and reading messages.

1. Visit [agent.qq.com](https://agent.qq.com) and register or sign in to Agent Mail.
2. Install the Agent Mail CLI:

   ```bash
   npm install -g @tencent-qqmail/agently-cli
   ```

3. Run `agently-cli auth login`, open the authorization link it displays, and finish the OAuth approval in your browser.
4. Confirm the connected agent mailbox with:

   ```bash
   agently-cli +me
   ```

Record the returned mailbox address in your recurring-job configuration. The workflow only needs read access plus permission to create Apple Reminders; do not authorize sending, replying, forwarding, deleting, downloading attachments, or opening email links unless you intentionally add those capabilities.

## Install

### Ask an agent to install it

For Codex, send an agent this exact message:

```text
Install the skill from https://github.com/Syck-zhang/mail-to-apple-reminders/tree/main/skills/mail-to-reminders
```

The skill's exact GitHub subdirectory matters: the repository root contains documentation and templates, while the installable skill lives in `skills/mail-to-reminders`.

### Install for Codex, Claude Code, or DeepSeek Harness

Clone the repository and use the installer. It refuses to overwrite an existing skill.

```bash
git clone https://github.com/Syck-zhang/mail-to-apple-reminders.git
cd mail-to-apple-reminders

./scripts/install-skill.sh codex
./scripts/install-skill.sh claude
./scripts/install-skill.sh dsh
```

For a different SKILL.md-aware agent, give its documented skills directory explicitly:

```bash
./scripts/install-skill.sh --dest /path/to/agent/skills
```

See [agent compatibility](docs/agent-compatibility.md) for personal vs. project installation paths and hosts without a skill loader.

### Manual install

Clone this repository, then add the `skills/mail-to-reminders` directory to your agent's skills directory or install it through its usual skills workflow.

```bash
git clone https://github.com/Syck-zhang/mail-to-apple-reminders.git
cp -R mail-to-apple-reminders/skills/mail-to-reminders ~/.codex/skills/
```

Copy the state template somewhere private and add it to your local ignore rules:

```bash
cp templates/state.example.json ~/.mail-to-reminders-state.json
```

Then read `skills/mail-to-reminders/references/setup.md` and use `automation-template.md` as the prompt for a recurring job.

## One-prompt setup and scheduling

Installing a skill only makes its workflow available; it does **not** automatically create a recurring job. To have an agent install or load the skill, complete the one-time mailbox authorization, run an initial check, and create a three-hour schedule in the current task, copy the appropriate prompt from [one-prompt setup](skills/mail-to-reminders/references/one-prompt-setup.md).

The prompt explicitly limits recurring authorization to reading new mail and managing Apple Reminders. It also instructs the agent to say so if its host has no scheduler, rather than pretending the workflow is running.

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
