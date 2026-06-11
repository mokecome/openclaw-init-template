# Skills 指南

> ⚠️ **設計鐵則：不要先堆 Skill。** 配 Skill 是開發動作，不是設計動作。
> 先完成「能力盤點 → 業務分析 → 系統架構」，確定了「幾個 Agent、各管什麼」之後，
> 再往對應子 Agent 的 `workspace-<id>/skills/` 裡裝技能。

## 兩類 Skill

| 類型 | 放哪裡 | 怎麼來 |
|------|--------|--------|
| **業務 Skill**（核心價值所在） | 各子 Agent 的 `workspace-<id>/skills/` | 多數手寫——越靠近合規邊界越要手寫（合規過濾層必須自己掌控）；每個 Skill 一個目錄，`SKILL.md` 寫清做什麼、何時用、怎麼用 |
| **通用 Skill**（生活/效率輔助） | 全局安裝，按需在 `config/openclaw.yaml` 的 `skills.entries` 啟用 | 從 Hub 安裝（命令以你 OpenClaw 版本的 hub CLI 為準，`clawhub` / `clawdhub`） |

## 通用 Skill 推薦（適合掛在 Router / main 上）

| 技能 | 用途 | 安裝命令 |
|------|------|---------|
| weather | 天氣查詢 | `clawdhub install weather` |
| remind-me | 自然語言提醒，自動創建 cron | `clawdhub install remind-me` |
| todo-tracker | 任務管理（優先級/完成狀態） | `clawdhub install jdrhyne/todo-tracker` |
| gog | Google 郵箱/日曆/文檔（需 OAuth） | `clawdhub install gog` |
| github | GitHub 操作 | 內置（需 `gh` CLI 登錄） |
| youtube-watcher | 視頻字幕摘要 | `clawdhub install youtube-watcher` |
| web-search | 網頁搜索 | 內置 |

完整列表見 [ClawHub](https://clawhub.com)。

## 業務 Skill 的目錄約定

```
workspace-agent-a/skills/
└── <skill-name>/            # 動名詞命名，如 parsing-resumes、scoring-candidates
    ├── SKILL.md             # 做什麼、何時用、怎麼用（Agent 執行前先讀它）
    └── scripts/             # 腳本（Python / Node / bash）
```

## 安全提醒

- 安裝第三方 Skill 前**檢查源碼**——它將獲得 Agent 的執行權限。
- 涉及敏感數據的處理鏈路（脫敏、過濾、審計），**不用第三方 Skill，自己手寫**。
