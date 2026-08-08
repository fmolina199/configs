# Bind Ctrl+l to start of the line
bindkey "^L" beginning-of-line

alias vim="nvim"
alias mtmux="cd repos && tmux new-session -A -s molina"

function rebase {
	if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		echo "Error: Not a git repository."
		return 1
	fi

	local default_remote="origin"
	if git remote | grep -q "^upstream$"; then
		default_remote="upstream"
	fi

	local target_branch="${1:-main}"
	local target_remote="${2:-$default_remote}"
	local stashed=0

	echo "Featching remote $target_remote"
	if ! git fetch "$target_remote"; then
		echo "❌ Failed to fetch from remote $target_remote. Aborting."
		return 1
	fi

	if ! git diff-index --quiet HEAD --; then
		echo "Uncommitted changes detected. Stashing..."
		git stash
		stashed=1
	else
		echo "No uncommitted changes detected."
	fi

	echo "Rebasing current branch onto '$target_remote/$target_branch'..."

	if git rebase "$target_remote/$target_branch"; then
		echo "✅ Rebase successful."

		if [ "$stashed" -eq 1 ]; then
			echo "Restoring stashed changes..."
			git stash pop
		fi
	else
		echo "❌ Rebase encountered an issue (e.g., merge conflicts)."
		echo "Automatic unstash aborted to prevent further conflicts."

		if [ "$stashed" -eq 1 ]; then
			echo "Note: Your uncommitted changes are safely stored. Once you resolve the rebase conflicts, run 'git stash pop' to restore them."
		fi
		return 1
	fi
}
