#!/bin/bash
# cmux sidebar metadata hook for Claude Code

# Read event from stdin
EVENT=$(cat)

# Skip if cmux is not running
[ -S "${CMUX_SOCKET_PATH:-/tmp/cmux.sock}" ] || exit 0

EVENT_TYPE=$(echo "$EVENT" | jq -r '.hook_event_name // "unknown"')
TOOL=$(echo "$EVENT" | jq -r '.tool_name // ""')
SESSION_ID=$(echo "$EVENT" | jq -r '.session_id // ""')

# Session-scoped count file
COUNT_FILE="/tmp/cmux-struggle-count-${SESSION_ID}"
CURRENT_FILE="/tmp/cmux-struggle-current"

# Track current session for statusline.sh
if [ -n "$SESSION_ID" ]; then
    echo "$SESSION_ID" > "$CURRENT_FILE"
fi

case "$EVENT_TYPE" in
    "PostToolUse"|"PostToolUseFailure")
        if [ -n "$TOOL" ]; then
            cmux log --level info --source claude "$TOOL"
        fi

        # PostToolUseFailure is always a struggle
        if [ "$EVENT_TYPE" = "PostToolUseFailure" ]; then
            STRUGGLE=1
        else
            # Detect struggle patterns in tool_response
            RESPONSE=$(echo "$EVENT" | jq -r '
                (.tool_response.stderr // "") + " " +
                (.tool_response.stdout // "") + " " +
                (.tool_response // "" | if type == "string" then . else "" end)
            ')

            STRUGGLE=$(echo "$RESPONSE" | grep -c -i -E \
                'error|failed|failure|not found|no such file|permission denied|cannot|could not|unable to|unexpected|refused|timeout|timed out|ENOENT|EACCES|EPERM|exit code [1-9]|command not found|syntax error|segfault|panic|fatal|abort|exception|traceback|compilation failed|build failed|test failed|存在しません|見つかりません|許可がありません|失敗|エラー|できません|できない|動かない|見つからない|ありません|無効|不正|拒否')
        fi

        TOTAL=$(awk '{print $1+0}' "$COUNT_FILE" 2>/dev/null || echo 0)

        if [ "$STRUGGLE" -gt 0 ]; then
            TOTAL=$((TOTAL + 1))
        fi

        echo "$TOTAL" > "$COUNT_FILE"
        ;;
    "Stop")
        cmux log --level success --source claude "Session complete"
        rm -f "$COUNT_FILE" "$CURRENT_FILE"
        ;;
esac
