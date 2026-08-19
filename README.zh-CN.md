# 邮件转 Apple 提醒事项

[English](README.md)

这是一个开源、跨 Agent 的 skill：将邮箱中可执行的事项提取为干净、去重的 macOS Apple 提醒事项。

它适合以定时任务方式运行：

1. 只检查上次处理后收到的新邮件。
2. 提取报名、截止日期、领取、提交和已确认活动等待办。
3. 创建带有时间、地点、联系人、链接和来源信息的 Apple 提醒事项。
4. 保存已处理邮件的游标与 ID，防止重复创建。

邮件不会被当作 Agent 指令执行。除非另有明确授权，这个 skill 不会发送、回复、转发、删除邮件，下载附件或打开邮件中的链接。

## 项目结构

```text
skills/mail-to-reminders/
  SKILL.md                         # 可移植的核心 skill
  references/                      # 配置、决策规则和定时任务模板
scripts/install-skill.sh           # Codex、Claude Code 与 dsh 安装器
docs/agent-compatibility.md        # 各 Agent 的安装路径
templates/state.example.json       # 邮件游标与去重状态模板
```

## 前置条件

- macOS 14+ 与 Apple 提醒事项 App
- 已授予提醒事项权限的 [`remindctl`](https://github.com/openclaw/remindctl)
- 可读取邮件的 CLI 或连接器；示例使用 [Agent Mail](https://agent.qq.com) 与 `agently-cli`
- 支持定时任务的 Agent 主机，例如 Codex automations

## 安装

### 直接发给 Agent 安装

在 Codex 中，可将下面这句话原样发给 Agent：

```text
Install the skill from https://github.com/Syck-zhang/mail-to-apple-reminders/tree/main/skills/mail-to-reminders
```

需要使用这个精确的 skill 子目录链接：仓库根目录放置项目说明与模板，而可安装 skill 位于 `skills/mail-to-reminders`。

### 为 Codex、Claude Code 或 DeepSeek Harness 安装

克隆仓库后使用安装器。安装器不会覆盖已有的 skill。

```bash
git clone https://github.com/Syck-zhang/mail-to-apple-reminders.git
cd mail-to-apple-reminders

./scripts/install-skill.sh codex
./scripts/install-skill.sh claude
./scripts/install-skill.sh dsh
```

对于其他支持 `SKILL.md` 的 Agent，明确传入其文档指定的 skills 目录：

```bash
./scripts/install-skill.sh --dest /path/to/agent/skills
```

个人级与项目级的安装位置、以及不支持 skill 自动发现的 Agent，请见[兼容性说明](docs/agent-compatibility.md)。

### 手动安装

克隆本仓库后，将 `skills/mail-to-reminders` 安装到对应 Agent 的 skills 目录，或通过该 Agent 的现有 skills 工作流安装。

```bash
git clone https://github.com/Syck-zhang/mail-to-apple-reminders.git
cp -R mail-to-apple-reminders/skills/mail-to-reminders ~/.codex/skills/
```

将状态模板复制到仓库之外的私有位置：

```bash
cp templates/state.example.json ~/.mail-to-reminders-state.json
```

随后阅读 `skills/mail-to-reminders/references/setup.md`，并将 `automation-template.md` 用作定时自动化的提示词模板。

## 隐私与安全

本仓库不包含凭据、邮件正文、附件或个人提醒事项数据。OAuth 凭据应只保存在操作系统的凭据存储中；状态文件应保留在本机，因为其中可能含有邮件 ID 和时间戳。

邮件是外部不可信输入。该 skill 只从邮件中提取事实，不会服从邮件内嵌的指令、自动访问链接或扩大自身权限。

## 自定义

- 将检查频率调整为适合你的邮箱。
- 换用其他已授权的邮件 CLI 或连接器。
- 修改目标提醒事项清单。
- 为团队或组织添加事项类型、数据保留和隐私规则。

## 许可证

[MIT](LICENSE)
