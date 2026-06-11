#!/usr/bin/env bash
# 一次性初始化腳本：把模板裡的佔位符改寫成本機實際值，並建好運行期空目錄。
# 用法：bash setup.sh <項目名>
#   例：bash setup.sh my-finance-bot
# 可重複運行（冪等）。
set -euo pipefail

PROJECT_NAME="${1:?用法: bash setup.sh <項目名>（小寫英數與連字符）}"
PROFILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> profile 目錄: ${PROFILE_DIR}"
echo "==> 項目名:       ${PROJECT_NAME}"

# 1. 改寫配置與 env.sh 裡的佔位符（__PROFILE_DIR__ / __PROJECT_NAME__）
for f in "${PROFILE_DIR}/config/openclaw.yaml" "${PROFILE_DIR}/env.sh"; do
  sed -i.bak \
    -e "s|__PROFILE_DIR__|${PROFILE_DIR}|g" \
    -e "s|__PROJECT_NAME__|${PROJECT_NAME}|g" \
    "$f"
  rm -f "${f}.bak"
done

# 2. 生成本地密鑰文件（已被 .gitignore 排除）——真實 Key 只填在 env.local.sh，永不提交
if [ ! -f "${PROFILE_DIR}/env.local.sh" ]; then
  cp "${PROFILE_DIR}/env.sh" "${PROFILE_DIR}/env.local.sh"
fi

# 3. 建好運行期空目錄（OpenClaw 首次啟動也會自建，這裡先確保存在）
mkdir -p "${PROFILE_DIR}/memory" \
         "${PROFILE_DIR}/logs" \
         "${PROFILE_DIR}/sessions" \
         "${PROFILE_DIR}/agents" \
         "${PROFILE_DIR}/cron"

# 4. 確保每個子 Agent 的三件套目錄齊全（物理隔離鐵則：workspace / agentDir / session 各自獨立）
for id in router agent-a agent-b; do
  mkdir -p "${PROFILE_DIR}/agent-dirs/${id}"
  mkdir -p "${PROFILE_DIR}/workspace-${id}"
done

echo ""
echo "==> 初始化完成。接下來："
echo "    1. 編輯 env.local.sh 填入 Gateway Token 與 LLM API Key（此文件不入 git）"
echo "    2. source ${PROFILE_DIR}/env.local.sh"
echo "    3. openclaw doctor          # 期望 Errors = 0"
echo "    4. openclaw gateway run     # 啟動 Gateway"
echo "    5. curl http://127.0.0.1:18790/health   # 期望返回 live"
