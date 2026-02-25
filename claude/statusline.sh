#!/bin/sh
# Claude Code status line script
# Displays: context tokens and usage % | working directory (basename)

input=$(cat)

current_dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
dir_name=$(basename "$current_dir")
# Truncate long directory names to 20 chars
if [ ${#dir_name} -gt 20 ]; then
    dir_name="$(echo "$dir_name" | cut -c1-19) …"
fi

used=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
tokens=$(echo "$input" | jq -r '(.context_window.current_usage.input_tokens // 0) + (.context_window.current_usage.cache_creation_input_tokens // 0) + (.context_window.current_usage.cache_read_input_tokens // 0)')

if [ -n "$tokens" ] && [ "$tokens" -gt 0 ] 2>/dev/null && [ -n "$used" ]; then
    used_int=$(printf "%.0f" "$used")
    tokens_k=$(awk "BEGIN { printf \"%.1f\", $tokens / 1000 }")
    printf "⛁ %sk(%s%%) | %s" "$tokens_k" "$used_int" "$dir_name"
else
    printf "⛁ - | %s" "$dir_name"
fi
