source "$CUSTOM_PATH/plugins.zsh"
source "$CUSTOM_PATH/keybindings.zsh"
source "$CUSTOM_PATH/aliases.zsh"
#echo ("printing from config directory")

# Open tmux on startup
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach-session -t default || tmux new-session -s default
fi

# Use y instead of yazi to start, and press q to quit, you'll see the CWD changed. Sometimes, you don't want to change, press Q to quit.
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
