# OpenClaw 多 Agent 初始配置模板

可複用的 OpenClaw **多 Agent 數字員工**初始 profile——1 個總控 Router + N 個業務子 Agent 的工業級骨架，開箱即含權限白名單、Lobster 審批（HiTL）、審計落盤、記憶系統。基於 [OpenClaw](https://openclaw.ai)，中文用戶友好。

<p align="center">
  <img src="https://img.shields.io/badge/OpenClaw-Multi--Agent-blueviolet" alt="OpenClaw Multi-Agent" />
  <img src="https://img.shields.io/badge/Language-中文-orange" alt="Chinese" />
  <img src="https://img.shields.io/badge/License-MIT-green" alt="MIT License" />
</p>

---

## ✨ 這是什麼？

做 AI 數字員工（HR、財務、客服、運營……）時，每個新項目的「地基階段」都在重複同樣的事：隔離 profile、Gateway 鑒權、多 Agent 骨架、agentToAgent 白名單、模型 fallback、審批工作流、審計日誌。這個模板把地基一次打好，**5 分鐘搭起骨架，把時間花在業務設計上**。

包含：

- 🧭 **Router + 子 Agent 骨架**：`workspace-router` + 2 個佔位子 Agent（`agent-a` / `agent-b`），複製即可擴展
- 🔐 **權限與隔離**：agentToAgent 白名單、subagents 白名單、per-Agent 工具權限、workspace/agentDir/session 三件套物理隔離
- ✅ **HiTL 審批**：Lobster 工作流插件預啟用，🔴 級決策（錄用/調薪/退款等）人類拍板
- 📜 **人設文件全套**：`SOUL.md` / `AGENTS.md` / `IDENTITY.md` / `USER.md` 模板，佔位符填空即用
- 💓 **心跳 + 記憶**：`HEARTBEAT.md` 檢查項、`MEMORY.md` + `memory/` 記憶系統
- 📊 **可觀測**：OTel 診斷預配置；落盤物三類約定（JSON / HTML / 審計日誌）
- 🧰 **腳本**：`setup.sh` 一鍵改寫路徑佔位符、生成不入庫的 `env.local.sh`

## 🚀 快速開始（5 步）

前提：已安裝 OpenClaw（`openclaw --version` 可輸出）。

```bash
# 1. 取模板，放到項目專屬目錄（每個項目一個獨立 profile）
git clone https://github.com/mokecome/openclaw-init-template.git ~/.openclaw-myproject
cd ~/.openclaw-myproject

# 2. 初始化：改寫路徑佔位符 + 生成 env.local.sh
bash setup.sh myproject

# 3. 填密鑰（env.local.sh 已被 .gitignore 排除，真實 Key 永不入庫）
nano env.local.sh    # 填 OPENCLAW_GATEWAY_TOKEN / DEEPSEEK_API_KEY / DASHSCOPE_API_KEY

# 4. 體檢 + 啟動
source env.local.sh
openclaw doctor          # 期望 Errors = 0
openclaw gateway run     # 保持此終端開著

# 5. 另開終端驗證
source ~/.openclaw-myproject/env.local.sh
curl http://127.0.0.1:18790/health
openclaw agent --agent router -m "你好，介紹一下你能做什麼"
```

## 📁 文件結構

```
.
├── README.md                 # 本指南
├── CHECKLIST.md              # 新項目套用檢查清單（設計 → 配置 → 驗收）
├── env.sh                    # 環境變數模板（佔位符，可提交）
├── setup.sh                  # 一鍵初始化（可重複運行）
├── config/openclaw.yaml      # 核心配置：Gateway、Agents、權限、模型、插件、hooks
├── cron/jobs.json            # 定時任務（空模板）
├── agent-dirs/               # 各 Agent 運行配置目錄（物理隔離三件套之一）
│   ├── router/  agent-a/  agent-b/
├── workspace-router/         # 總控 Router 的家
│   ├── SOUL.md               # 人設：只做判斷領域/分發/彙總，絕不自答業務
│   ├── AGENTS.md             # 工作守則（記憶、紅線、heartbeat vs cron）
│   ├── IDENTITY.md USER.md HEARTBEAT.md MEMORY.md TOOLS.md
├── workspace-agent-a/        # 業務子 Agent A 的家（複製此目錄擴展新 Agent）
│   ├── SOUL.md               # 人設：負責事項表（HiTL 三檔）、落盤物約定、紅線
│   ├── AGENTS.md  TOOLS.md
│   └── skills/               # 業務 Skill 放這裡（每個 Skill 一個目錄 + SKILL.md）
├── workspace-agent-b/        # 業務子 Agent B（同上）
└── docs/SKILLS-GUIDE.md      # Skills 指南（業務 Skill 約定 + 通用 Skill 推薦）
```

## 🧩 架構一覽

```
                [你的數字員工]
                      │
               ┌──────┴──────┐
               │ 總控 Router  │   ← 唯一入口：判斷領域 → sessions_spawn 分發 → 彙總
               └──────┬──────┘
            ┌─────────┴─────────┐
         agent-a             agent-b        ← 業務子 Agent（各自 workspace + skills）
            │                   │
     ──────────── 工業級公共底座 ────────────
     OTel 可觀測 / 權限白名單 / Cron / Lobster 審批 / 審計日誌
```

每條配置都對應多 Agent 系統設計的 5 個決策：

| 決策 | 對應文件 |
|------|---------|
| 1. Agent 是誰、按什麼規矩工作 | 各 workspace 的 `SOUL.md` / `AGENTS.md` |
| 2. Agent 會做什麼 | `workspace-*/skills/` + MCP |
| 3. 系統怎麼擴展、消息從哪進 | `config/openclaw.yaml` plugins / channels |
| 4. 流程怎麼編排、哪裡要審批 | Lobster 工作流（已啟用） |
| 5. 幾個 Agent、怎麼協作 | `agents.list` + 兩層白名單 |

## 🔧 套用到新項目

1. **跑四步法設計**：能力盤點 → 業務分析 → 系統架構 → 開發計劃（見 `CHECKLIST.md` 第一段；先設計，**不要先堆 Skill**）
2. **子 Agent 改名**（如 `agent-a` → `recruitment`），**五處同步**：
   `workspace-<id>/` 目錄名、`agent-dirs/<id>/` 目錄名、`agents.list`、`tools.agentToAgent.allow`、router 的 `subagents.allowAgents`
3. **新增子 Agent**：複製 `workspace-agent-a/` 整個目錄 → 改名 → 五處登記 → `setup.sh` 的 id 列表加一行
4. **填人設**：把各 `SOUL.md` / `USER.md` 裡的 `[佔位]` 換成業務內容
5. **唯讀型 Agent**（如政策問答）：用 `tools.deny` 收權限，參考
   ```json
   "tools": { "deny": ["write", "edit", "apply_patch", "browser"] }
   ```
6. **按 `CHECKLIST.md` 驗收**：doctor Errors=0、/health live、路由分發跑通、Lobster 含 resume 跑通、落盤三類齊全

## 🔒 安全提醒

- ⚠️ 真實 API Key 只填 `env.local.sh`（已 gitignore），`env.sh` 只放佔位符
- ⚠️ 對個人有重大影響的決策（錄用/淘汰/調薪/退款/核保…）必須走 Lobster 審批，由人類最終拍板
- ⚠️ 審計日誌五要素不可省：誰、何時、做了什麼、依據什麼、結果
- ⚠️ 安裝第三方 Skill 前檢查源碼；合規過濾層自己手寫
- ⚠️ 定期清理 `MEMORY.md` 中的敏感信息；群聊上下文不載入 MEMORY.md

## 👤 關於

由 [MIKE](https://github.com/mokecome) 創建維護。

- 🐦 Twitter: https://x.com/mokecome
- 💬 LINE: mokecome

## 📄 License

MIT License - 自由使用、修改、分發。
