# OpenClaw 多 Agent 通用初始 profile · 環境變數
# ============================================================
# 使用前必須做兩件事：
#   1. 填入下面 3 個佔位符（你自己的 API Key + 一個自定的 Gateway Token）
#   2. 先運行同目錄下的 setup.sh，自動改寫 profile 裡的佔位路徑
# ============================================================

# profile 狀態目錄與配置路徑 —— 改成你放置這個 profile 的實際位置
# 建議每個項目一個獨立目錄，如 ~/.openclaw-<項目名>，做到 profile 級隔離
export OPENCLAW_STATE_DIR=$HOME/.openclaw-__PROJECT_NAME__
export OPENCLAW_CONFIG_PATH=$OPENCLAW_STATE_DIR/config/openclaw.yaml

# Gateway 鑒權 Token —— 自己設一個隨機字符串即可（Gateway 與客戶端之間的共享密鑰，
# 不是對外申請的；可用 `openssl rand -base64 32` 生成一個）
export OPENCLAW_GATEWAY_TOKEN="<在此填入一個你自定的隨機字符串>"

# --- LLM Provider API Key —— 填入你自己申請的 Key ---
# openclaw.yaml 裡只用 SecretRef 引用這兩個變量名，明文 Key 只存在本文件，不進配置、不進 git。
# DeepSeek：https://platform.deepseek.com
# 通義/百煉 DashScope：https://bailian.console.aliyun.com（也供 memorySearch 向量檢索用）
export DEEPSEEK_API_KEY="<在此填入你的 DeepSeek API Key>"
export DASHSCOPE_API_KEY="<在此填入你的阿里雲百煉 DashScope API Key>"

# OpenClaw 可執行文件路徑 —— 已在 PATH 中則自動探測
export OPENCLAW_BIN="$(command -v openclaw || echo '<在此填入你本機 openclaw 可執行文件路徑>')"

# alias 方便手動調試
alias openclaw-__PROJECT_NAME__="$OPENCLAW_BIN"
