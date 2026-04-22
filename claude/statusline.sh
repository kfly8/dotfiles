#!/bin/sh
# Claude Code status line script
# Line 1: context% | estimated cost | model
# Line 2: git branch [worktree]

input=$(cat)

# Metrics
used=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
model=$(echo "$input" | jq -r '.model.id // .model // empty')
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')

# Worktree JSON fields (set when EnterWorktree is active)
wt_branch=$(echo "$input" | jq -r '.worktree.branch // empty')
wt_name=$(echo "$input" | jq -r '.worktree.name // .workspace.git_worktree // empty')

# Format metrics
used_int=$(printf "%.0f" "$used" 2>/dev/null || echo "0")
cost_fmt=$(awk "BEGIN { printf \"%.3f\", $cost }")
model_short=$(echo "${model:--}" | sed 's/^claude-//')

# Git info from current_dir
git_branch=""
git_wt_label=""
if [ -n "$current_dir" ]; then
    git_branch=$(git -C "$current_dir" branch --show-current 2>/dev/null)

    # Fallback for detached HEAD
    if [ -z "$git_branch" ]; then
        git_branch=$(git -C "$current_dir" rev-parse --short HEAD 2>/dev/null)
        [ -n "$git_branch" ] && git_branch="(${git_branch})"
    fi

    # Detect worktree via git: --absolute-git-dir contains /worktrees/ for linked worktrees
    abs_git_dir=$(git -C "$current_dir" rev-parse --absolute-git-dir 2>/dev/null)
    if echo "$abs_git_dir" | grep -q '/worktrees/'; then
        git_wt_label=$(echo "$abs_git_dir" | sed 's|.*/worktrees/\([^/]*\).*|\1|')
    fi
fi

# Determine branch and worktree label to display
if [ -n "$wt_branch" ]; then
    # EnterWorktree is active
    display_branch="$wt_branch"
    display_label=" [${wt_name:-worktree}]"
elif [ -n "$wt_name" ]; then
    # workspace.git_worktree is set
    display_branch="${git_branch:-?}"
    display_label=" [$wt_name]"
elif [ -n "$git_wt_label" ]; then
    # Detected as git worktree via git command
    display_branch="${git_branch:-?}"
    display_label=" [$git_wt_label]"
else
    display_branch="${git_branch:-$(basename "${current_dir:-/}")}"
    display_label=""
fi

echo "ctx:${used_int}% \$${cost_fmt} ${model_short}"
echo "${display_branch}${display_label}"
