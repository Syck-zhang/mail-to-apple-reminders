# 邮件转 Apple 提醒事项

[English](README.md)

这是一个面向 Codex 和 Claude Code 的开源 skill：将邮箱中可执行的事项提取为清晰、去重的 macOS Apple 提醒事项。

它适合以定时任务方式运行：

1. 只检查上次处理后收到的新邮件。
2. 提取报名、截止日期、领取、提交和已确认活动等待办。
3. 创建带有时间、地点、联系人、链接和来源信息的 Apple 提醒事项。
4. 保存已处理邮件的游标与 ID，防止重复创建。

邮件是不可信输入。这个 skill 只提取待办事实；除非另有明确授权，它不会发送、回复、转发、删除邮件、下载附件或打开邮件链接。

## 从这里开始

1. 创建并授权专用的 [Agent Mail](https://agent.qq.com) 邮箱，步骤见[配置指南](skills/mail-to-reminders/references/setup.md)。
2. 将对应的[一段提示词完成设置](skills/mail-to-reminders/references/one-prompt-setup.md)发给 Agent。它会安装或加载 skill、在需要时完成授权，并执行首次邮件检查。
3. 将状态文件保留在私有位置，从 [`templates/state.example.json`](templates/state.example.json) 开始。

设置提示词明确把持续授权限制在读取新邮件与管理 Apple 提醒事项。Codex 可以在当前任务中创建自动化；Claude Code 的循环执行需要外部定时器。

## 需要准备

- macOS 14+ 与 Apple 提醒事项 App
- 已授予提醒事项权限的 [`remindctl`](https://github.com/openclaw/remindctl)
- 已注册的 Agent Mail 邮箱与 [`agently-cli`](https://agent.qq.com)，或其他已获用户授权、支持列出及读取邮件的工具
- 定时器：Codex automations，或 Claude Code 的外部定时器

## 安装

个人级、项目级与自定义 skill 目录的安装方式，见[安装指南](docs/agent-compatibility.md)。简要命令如下：

```bash
git clone https://github.com/Syck-zhang/mail-to-apple-reminders.git
cd mail-to-apple-reminders
./scripts/install-skill.sh codex   # 或：claude
```

## 仓库地图

| 路径 | 作用 |
| --- | --- |
| [`skills/mail-to-reminders/`](skills/mail-to-reminders) | 可安装 skill 及其运行参考资料 |
| [`docs/agent-compatibility.md`](docs/agent-compatibility.md) | Codex 与 Claude Code 的安装及定时差异 |
| [`scripts/install-skill.sh`](scripts/install-skill.sh) | 安全的个人级/自定义目录安装器 |
| [`templates/state.example.json`](templates/state.example.json) | 私有状态文件起点 |

## 隐私

本仓库不包含凭据、邮件正文、附件或个人提醒事项数据。OAuth 凭据应只保存在操作系统的凭据存储中；状态文件应保留在本机，因为其中可能含有邮件 ID 和时间戳。

## 许可证

[MIT](LICENSE)
