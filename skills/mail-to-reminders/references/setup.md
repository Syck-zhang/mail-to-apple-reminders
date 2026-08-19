# Setup and permissions

## Requirements

- macOS 14 or later with the Reminders app.
- [`remindctl`](https://github.com/openclaw/remindctl), with Reminders access granted to the terminal or host app that runs it.
- A registered Agent Mail inbox and a mail CLI with structured list/read support. This repository uses [`agently-cli`](https://agent.qq.com) examples.

## Agent Mail onboarding

Register or sign in at [agent.qq.com](https://agent.qq.com), then install and authorize the CLI:

```bash
npm install -g @tencent-qqmail/agently-cli
agently-cli auth login
```

Complete the OAuth approval in a browser. Confirm the connected mailbox with `agently-cli +me`, then use that mailbox address in the scheduler configuration.

Install `remindctl` using the tool's documented Homebrew command. Do not commit OAuth tokens, macOS keychain exports, mailbox addresses, or reminder data.

Check access before a first live run:

```bash
remindctl status --json
agently-cli +me
```

## Suggested local state file

Copy `templates/state.example.json` outside the repository or add the chosen state path to `.gitignore`. The state file lets scheduled runs process only new messages and provides an audit-friendly de-duplication record.

## Scheduling

Use the scheduling facility in the host agent (for example, a Codex heartbeat). Do not keep a long-running terminal watcher alive unless the host environment is designed for it. A periodic run is more resilient to restarts.

Choose a cadence appropriate to the mailbox: every 2–4 hours works well for ordinary personal email. The schedule must be explicit and user-approved.
