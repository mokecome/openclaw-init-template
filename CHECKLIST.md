# 新項目套用檢查清單

> 從模板到能跑的系統，按順序走完三段。每條驗收標準都可判真偽——全真才算完成，沒有「基本完成」。

## 一、設計階段（動配置之前）

先回答 5 個系統設計決策，每條配置都應能追溯到其中一個：

| # | 決策 | 對應模板文件 |
|---|------|-------------|
| 1 | Agent 是誰？按什麼規矩工作？ | 各 workspace 的 `SOUL.md` / `AGENTS.md` |
| 2 | Agent 會做什麼？ | 各 workspace 的 `skills/`（+ MCP） |
| 3 | 系統怎麼擴展？消息從哪進來？ | `config/openclaw.yaml` 的 plugins / channels |
| 4 | 多步流程怎麼編排？哪裡要審批？ | Lobster 工作流（plugins.lobster） |
| 5 | 系統由幾個 Agent？怎麼協作？ | `agents.list` + router 白名單 |

- [ ] 完成業務拆解：每個工作事項都能直接回答「用什麼技術做」（不太粗也不太細）
- [ ] 每個事項標好 HiTL 三檔：🟢 全自動 / 🟡 AI 草稿→人工複核 / 🔴 人類最終決策
- [ ] **🔴 事項清單 = Lobster 審批節點清單**（數量一一對應，逐條寫明法源/業務理由）
- [ ] 每個子 Agent 候選跑過「7 問判斷公式」，尤其第 7 問否決項：
  1. 是不是穩定業務領域？ 2. 資料要隔離嗎？ 3. 工具權限不同嗎？ 4. 合規紅線不同嗎？
  5. 有自己的長期狀態/產物嗎？ 6. 需要獨立演進節奏嗎？
  7. 🚫 **否決項**：自動化空間夠嗎？（80%+ 必須人工 → 不成 Agent，改 Skill 或掛別人下）
  - 前 6 問 ≥4 是 + 第 7 問通過 → 獨立 Agent；≤1 是 → 做成 Skill/MCP
- [ ] **沒有先堆 Skill**——Skill 清單是設計的產物，不是起點

## 二、配置階段（改模板）

子 Agent 改名/新增時，**五處必須同步**（漏一處就路由不通或越權）：

- [ ] `workspace-<id>/` 目錄名
- [ ] `agent-dirs/<id>/` 目錄名
- [ ] `config/openclaw.yaml` → `agents.list` 的 `id` / `name` / `workspace` / `agentDir`
- [ ] `config/openclaw.yaml` → `tools.agentToAgent.allow` 白名單
- [ ] `config/openclaw.yaml` → router 的 `subagents.allowAgents` 白名單

其他配置項：

- [ ] **物理隔離鐵則**：每個子 Agent 的 workspace / agentDir / session 三件套各自獨立，**絕不複用 agentDir**
- [ ] 每個子 Agent 按「最小權限」配 `tools.allow`；唯讀型 Agent 用 `tools.deny`（參考：`["write","edit","apply_patch","browser"]`）
- [ ] Router 的 `SOUL.md` 填好：子 Agent 表、路由觸發詞、紅線
- [ ] 各子 Agent 的 `SOUL.md` 填好：負責事項表（含 HiTL 三檔）、落盤物約定、紅線
- [ ] `env.local.sh` 填好 Token 與 API Key（確認 `git status` 看不到它）
- [ ] 模型 provider 按需替換（默認 DeepSeek 主 + Qwen fallback；換 provider 同步改 `models.providers` 與 `agents.defaults.model`）

## 三、驗收階段（地基完成的硬條件）

- [ ] `openclaw doctor` → **Errors = 0**（profile 隔離類 Warnings 可放行）
- [ ] `curl http://127.0.0.1:18790/health` → 返回 live，HTTP 200
- [ ] `openclaw agent --agent router -m "測試"` → router 能應答
- [ ] 對每個子 Agent 直連發一條領域內消息 → 各自能應答
- [ ] router 收到業務請求 → 能用 `sessions_spawn` 正確分發（不自答業務問題）
- [ ] Lobster 跑通一條**含 resume 的最小審批工作流**（中斷 → 人工批准 → 恢復）
- [ ] 任一任務產出落盤三類齊全：JSON（給程式）/ HTML（給人）/ 審計日誌（誰、何時、做了什麼、依據什麼、結果）
