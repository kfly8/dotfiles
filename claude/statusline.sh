#!/bin/sh
# Claude Code status line script
# Displays: context tokens and usage % | error count | working directory (basename)
# Also sends context info to cmux sidebar if available

input=$(cat)

current_dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
dir_name=$(basename "$current_dir")
# Truncate long directory names to 20 chars
if [ ${#dir_name} -gt 20 ]; then
    dir_name="$(echo "$dir_name" | cut -c1-19) …"
fi

used=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
tokens=$(echo "$input" | jq -r '(.context_window.current_usage.input_tokens // 0) + (.context_window.current_usage.cache_creation_input_tokens // 0) + (.context_window.current_usage.cache_read_input_tokens // 0)')

# Read session-scoped error count
session_id=$(cat /tmp/cmux-struggle-current 2>/dev/null)
if [ -n "$session_id" ]; then
    err_count=$(awk '{print $1+0}' "/tmp/cmux-struggle-count-${session_id}" 2>/dev/null || echo 0)
else
    err_count=0
fi

if [ -n "$tokens" ] && [ "$tokens" -gt 0 ] 2>/dev/null && [ -n "$used" ]; then
    used_int=$(printf "%.0f" "$used")
    tokens_k=$(awk "BEGIN { printf \"%.1f\", $tokens / 1000 }")

    # Claude Code status line output
    if [ "$err_count" -gt 0 ]; then
        printf "⛁ %sk(%s%%) | err: %s | %s" "$tokens_k" "$used_int" "$err_count" "$dir_name"
    else
        printf "⛁ %sk(%s%%) | %s" "$tokens_k" "$used_int" "$dir_name"
    fi

    # Send context info to cmux sidebar
    if [ -S "${CMUX_SOCKET_PATH:-/tmp/cmux.sock}" ] && command -v cmux >/dev/null 2>&1; then
        if [ "$used_int" -ge 80 ]; then
            color="#ff3b30"
        elif [ "$used_int" -ge 50 ]; then
            color="#ff9500"
        else
            color="#34c759"
        fi
        ratio=$(awk "BEGIN { printf \"%.4f\", $used / 100 }")
        if [ "$err_count" -gt 0 ]; then
            label="⛁ ${tokens_k}k(${used_int}%) | err: ${err_count}"
        else
            label="⛁ ${tokens_k}k(${used_int}%)"
        fi
        cmux set-progress "$ratio" --label "$label" --color "$color" 2>/dev/null
    fi
else
    printf "⛁ - | %s" "$dir_name"
fi
