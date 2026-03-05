#!/bin/bash
# cmux sidebar metadata hook for Claude Code
# Place: ~/src/github.com/kfly8/dotfiles/claude/hooks/cmux-sidebar.sh
# Symlink: ln -sf ~/src/github.com/kfly8/dotfiles/claude/hooks/cmux-sidebar.sh ~/.claude/hooks/cmux-sidebar.sh

# cmux が起動していない場合はスキップ
[ -S "${CMUX_SOCKET_PATH:-/tmp/cmux.sock}" ] || exit 0

EVENT=$(cat)
EVENT_TYPE=$(echo "$EVENT" | jq -r '.event // "unknown"')
TOOL=$(echo "$EVENT" | jq -r '.tool_name // ""')

# --- コンテキスト消費量 ---
INPUT_TOKENS=$(echo "$EVENT" | jq -r '.usage.input_tokens // 0')
CACHE_TOKENS=$(echo "$EVENT" | jq -r '.usage.cache_read_input_tokens // 0')
OUTPUT_TOKENS=$(echo "$EVENT" | jq -r '.usage.output_tokens // 0')
TOTAL=$(( INPUT_TOKENS + CACHE_TOKENS + OUTPUT_TOKENS ))
MAX_CONTEXT=200000

if [ "$TOTAL" -gt 0 ]; then
    PCT=$(( TOTAL * 100 / MAX_CONTEXT ))
    RATIO=$(echo "scale=4; $TOTAL / $MAX_CONTEXT" | bc 2>/dev/null || echo "0")

    # 消費率に応じて色を変える
    if [ "$PCT" -ge 80 ]; then
        COLOR="#ff3b30"  # 赤: 危険域
    elif [ "$PCT" -ge 50 ]; then
        COLOR="#ff9500"  # オレンジ: 注意域
    else
        COLOR="#34c759"  # 緑: 余裕あり
    fi

    cmux set-status context "${PCT}%" --color "$COLOR"
    cmux set-progress "$RATIO" --label "Context: ${PCT}% (${TOTAL}/${MAX_CONTEXT})"
fi

# --- 進捗状況 ---
case "$EVENT_TYPE" in
    "PostToolUse")
        if [ -n "$TOOL" ]; then
            cmux set-status task "$TOOL" --color "#5ac8fa"
            cmux log --level info --source claude "$TOOL"
        fi
        ;;
    "Stop")
        cmux set-status task "完了" --color "#34c759"
        cmux log --level success --source claude "セッション完了"
        ;;
    "PreToolUse")
        if [ -n "$TOOL" ]; then
            cmux set-status task "⏳ $TOOL" --color "#ffcc00"
        fi
        ;;
esac
