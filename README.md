你的 AI 私人助手，一鍵啟動。基於 [OpenClaw](https://openclaw.ai)（原 Clawdbot），中文用戶友好。

<p align="center">
  <img src="https://img.shields.io/badge/OpenClaw-100k%2B%20⭐-blueviolet" alt="OpenClaw Stars" />
  <img src="https://img.shields.io/badge/Language-中文-orange" alt="Chinese" />
  <img src="https://img.shields.io/badge/License-MIT-green" alt="MIT License" />
</p>

---

## ✨ 這是什麼？

一個預配置好的 OpenClaw AI 助手模板，幫你跳過繁瑣的初始化，**5 分鐘擁有自己的 AI 私人助手**。

包含：
- 📜 **靈魂三件套**：`SOUL.md` / `USER.md` / `IDENTITY.md` 模板
- 💓 **心跳配置**：`HEARTBEAT.md` 預設日常檢查項
- 🧠 **記憶系統**：`MEMORY.md` + `memory/` 目錄結構
- 📋 **工作指南**：`AGENTS.md` 行為準則
- 🔧 **工具筆記**：`TOOLS.md` 本地工具速查
- 📚 **推薦 Skills**：精選實用技能列表

## 🚀 快速開始

### 1. 安裝 OpenClaw

```bash
npm install -g openclaw
```

### 2. 使用模板

```bash
# 克隆此模板
git clone https://github.com/mengjian-github/xiaomo-starter-kit.git my-assistant
cd my-assistant

# 或者直接用 GitHub 的 "Use this template" 按鈕
```

### 3. 個性化配置

編輯以下文件，把助手變成「你的」：

```bash
# 定義助手的性格和行為
nano SOUL.md

# 告訴助手關於你的信息
nano USER.md

# 給助手起名字、設定形象
nano IDENTITY.md
```

### 4. 啟動

```bash
openclaw gateway start
```

然後在 Telegram / WhatsApp / Discord 上跟你的助手說聲「你好」！

## 📁 文件結構

```
my-assistant/
├── AGENTS.md          # 助手的行為準則和工作流程
├── SOUL.md            # 靈魂文件：性格、語氣、邊界
├── USER.md            # 用戶畫像：讓助手瞭解你
├── IDENTITY.md        # 身份設定：名字、形象、Vibe
├── HEARTBEAT.md       # 心跳檢查項：助手定期自動執行
├── MEMORY.md          # 長期記憶：重要事件和經驗
├── TOOLS.md           # 工具筆記：本地配置速查
├── TODO.md            # 任務清單
├── memory/            # 每日記憶文件
│   └── .gitkeep
├── content/           # 內容輸出目錄
│   └── .gitkeep
└── docs/
    └── SKILLS-GUIDE.md  # 推薦技能清單和安裝指南
```

## 🧩 推薦 Skills

| 技能 | 用途 | 安裝命令 |
|------|------|---------|
| weather | 天氣查詢 | `clawdhub install weather` |
| github | GitHub 操作 | 內置 |
| todo-tracker | 任務管理 | `clawdhub install jdrhyne/todo-tracker` |
| remind-me | 自然語言提醒 | `clawdhub install remind-me` |
| gog | Google 郵箱/日曆/文檔 | `clawdhub install gog` |
| youtube-watcher | 視頻摘要 | `clawdhub install youtube-watcher` |
| web-search | 網頁搜索 | 內置 |

完整技能列表請查看 [ClawdHub](https://clawdhub.com)。

## 📖 6 天從入門到上手

我們寫了一份詳細的《人人都該有一個 AI 私人助手》6 天指南：

- **Day 1**: 一行命令搭建你的AI助手
- **Day 2**: 下載模板設定個性化
- **Day 3**: 接入數字生活
- **Day 4**: 擴展技能
- **Day 5**: 讓助手主動工作
- **Day 6**: 進階玩法

## 🔒 安全提醒

- ⚠️ 不要把 API Key 提交到 Git（使用 `.env` 或環境變量）
- ⚠️ 安裝 Skill 前檢查源碼
- ⚠️ `clawdbot.json` 配置文件權限建議設為 `chmod 600`
- ⚠️ 定期檢查和清理 `MEMORY.md` 中的敏感信息

## 👤 關於

由 [MIKE] (https://github.com/mokecome)) 和小堂 共同創建。

- 🐦 Twitter: https://x.com/mokecome
- 💬 LINE：mokecome

## 📄 License

MIT License - 自由使用、修改、分發。

---
