# banner.zsh — zsh startup banner: mascot · status lines · quiet logs
#
#          ▼ q₀       isg · zsh
#   ┄┬─┬─┬─┬─┬─┬┄     Wed 11 Jun 2026 · 20:42
#   ┄┤0│1│1│0│1├┄     ~/.dotfiles · main
#   ┄┴─┴─┴─┴─┴─┴┄
#     · ssh-agent started · pid 724
#     · Identity added: /Users/isg/.ssh/delos-new (...)
#
# Interface
#   banner_info "text"     add a status line, shown right of the mascot
#                          (prompt escapes allowed: %B %F{..} %~ %D{..} ...)
#   banner_log  "text"     add a dim log line, shown below the banner
#   banner_run  cmd ...    run a noisy command, demoting its output to logs
#   banner_render          draw everything — call once, at the end of .zshrc
#
# Config
#   BANNER_DISABLE=1           skip rendering entirely
#   BANNER_ACCENT=color        mascot color (default: yellow)

[[ -o interactive ]] || return 0

typeset -ga _banner_info_lines=()
typeset -ga _banner_log_lines=()

banner_info() { _banner_info_lines+=("$*") }
banner_log()  { _banner_log_lines+=("$*") }

banner_run() {
    local _out _line
    _out="$("$@" 2>&1)"
    for _line in ${(f)_out}; do
        banner_log "$_line"
    done
}

# ── mascot: turing machine tape ──
# Keep all lines the same display width (_banner_mascot_width).
# Head in state q₀, parked over a cell. Swap art freely.
typeset -ga _banner_mascot=(
    '       ▼ q₀'
    '┄┬─┬─┬─┬─┬─┬┄'
    '┄┤0│1│1│0│1├┄'
    '┄┴─┴─┴─┴─┴─┴┄'
)
typeset -g _banner_mascot_width=15

# Alternative: tape spells the owner, head parked on `i`
#   '       ▼'
#   '┄┬─┬─┬─┬─┬─┬┄'
#   '┄┤0│1│i│s│g├┄'
#   '┄┴─┴─┴─┴─┴─┴┄'
#
# Alternative: chunky block tape (delos style)
#   '      ▗█▖'
#   '▄▄▄▄▄▄▟█▙▄▄▄▄'
#   '▌0▐1▐0█1█▌1▐0'
#   '▀▀▀▀▀▀▀▀▀▀▀▀▀'

banner_render() {
    [[ -n $BANNER_DISABLE ]] && return 0
    local -i i rows
    local mascot info line
    rows=$(( ${#_banner_mascot} > ${#_banner_info_lines} \
             ? ${#_banner_mascot} : ${#_banner_info_lines} ))
    print
    for (( i = 1; i <= rows; i++ )); do
        mascot="${_banner_mascot[i]:-}"
        info="${_banner_info_lines[i]:-}"
        print -P -- "  %F{${BANNER_ACCENT:-yellow}}${(r:${_banner_mascot_width}:)mascot}%f   ${info}"
    done
    for line in "${_banner_log_lines[@]}"; do
        print -P -- "    %F{8}· ${line//\%/%%}%f"
    done
    print
    # consumed — a re-source/re-render starts clean
    _banner_info_lines=() _banner_log_lines=()
}
