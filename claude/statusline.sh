#!/bin/sh
# Claude Code status line script
# Displays: turn tokens (in/out, cache%) | cost | context% | dir

input=$(cat)

current_dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
dir_name=$(basename "$current_dir")
if [ ${#dir_name} -gt 40 ]; then
    dir_name="$(echo "$dir_name" | cut -c1-39)…"
fi

in_tok=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0')
out_tok=$(echo "$input" | jq -r '.context_window.current_usage.output_tokens // 0')
cache_create=$(echo "$input" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0')
cache_read=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')
used=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')

total_in=$((in_tok + cache_create + cache_read))

if [ "$total_in" -gt 0 ] 2>/dev/null; then
    in_k=$(awk "BEGIN { printf \"%.0f\", $total_in / 1000 }")
    out_k=$(awk "BEGIN { printf \"%.1f\", $out_tok / 1000 }")
    cache_pct=$(awk "BEGIN { printf \"%.0f\", ($cache_read / $total_in) * 100 }")
    used_int=$(printf "%.0f" "$used")
    cost_fmt=$(awk "BEGIN { printf \"%.3f\", $cost }")
    echo "⛁ I:${in_k}k O:${out_k}k C:${cache_pct}% | \$${cost_fmt} | ctx:${used_int}%"
    echo "${dir_name}"
else
    echo "⛁ -"
    echo "${dir_name}"
fi
