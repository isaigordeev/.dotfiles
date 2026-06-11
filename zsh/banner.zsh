# banner.zsh — zsh startup banner: mascot · status lines · quiet logs
#
#          ▼ q₀        isg · zsh
#   ┄┬─┬─┬─┬─┬─┬┄      Wed 11 Jun 2026 · 20:42
#   ┄┤0│1│1│0│1├┄      ~/.dotfiles · main
#   ┄┴─┴─┴─┴─┴─┴┄
#   δ(q₀,0)=⟨B,1,R⟩
#     · ssh-agent started · pid 724
#     · Identity added: /Users/isg/.ssh/delos-new (...)
#
# Interface
#   banner_info "text"        add a status line, shown right of the mascot
#                             (prompt escapes allowed: %B %F{..} %~ %D{..} ...)
#   BANNER_LOG_FUNCS=( ... )  registry of log funcs, run in order by render —
#                             each func holds one log message (banner_logs.zsh)
#   banner_log  "text"        add a dim log line, shown below the banner
#   banner_run  cmd ...       run a noisy command, demoting its output to logs
#   banner_render             consume the registry and draw — call once, last
#
# Config
#   BANNER_DISABLE=1           skip rendering entirely
#   BANNER_ACCENT=color        mascot color (default: yellow)

[[ -o interactive ]] || return 0

typeset -ga BANNER_LOG_FUNCS=()
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
# Lines may be shorter than _banner_mascot_width (they get padded) but
# never longer (they get truncated). Swap art freely.
#
# A Turing machine is the 7-tuple M = ⟨Q,Γ,b,Σ,δ,q₀,F⟩ (Hopcroft &
# Ullman) — here instantiated as the 3-state busy beaver:
#
#   Q    set of states                   {A, B, C, HALT}
#   Γ    tape alphabet                   {0, 1}
#   b    blank symbol,  b ∈ Γ            0
#   Σ    input symbols, Σ ⊆ Γ∖{b}        {1}
#   δ    transition function             (Q∖F) × Γ ⇀ Q × Γ × {L,R}
#   q₀   initial state, q₀ ∈ Q           A
#   F    final states,  F ⊆ Q            {HALT}
#
# δ takes a pair (current state, symbol under the head) and returns a
# triple (next state, symbol to write, head move):
#
#   δ(q₀, 0) = ⟨B, 1, R⟩
#      │   │     │  │  │
#      │   │     │  │  └─ then move the head one cell Right
#      │   │     │  └──── write 1 over the 0
#      │   │     └─────── switch to state B
#      │   └───────────── ...while reading symbol 0
#      └───────────────── in state q₀ (= state A, the initial state)...
#
# The mascot is that machine at step zero:
#
#          ▼ q₀          head in the initial state q₀ (=A), reading 0
#   ┄┬─┬─┬─┬─┬─┬┄
#   ┄┤0│1│1│0│1├┄        the tape; ┄ = blanks (b=0) to infinity
#   ┄┴─┴─┴─┴─┴─┴┄
#   δ(q₀,0)=⟨B,1,R⟩      the next move, computed but not yet taken
#
# The machine looks up δ for (q₀, 0) — the top-left entry of the busy
# beaver state table. One step later the tape would read 0│1│1│1│1 and
# the head would sit one cell to the right, labeled ▼ q_B. So the
# banner is a freeze-frame of the machine mid-thought.
#
# Why it ever stops: δ is partial — when no rule exists for the current
# (state, symbol) pair, the machine halts. The busy beaver reaches the
# explicit HALT ∈ F state after 14 steps, having written six 1s — the
# most a 3-state machine can do and still terminate. A fitting mascot
# for a shell: maximum output, guaranteed to terminate.
typeset -ga _banner_mascot=(
    '       ▼ q₀'
    '┄┬─┬─┬─┬─┬─┬┄'
    '┄┤0│1│1│0│1├┄'
    '┄┴─┴─┴─┴─┴─┴┄'
    'δ(q₀,0)=⟨B,1,R⟩'
)
typeset -g _banner_mascot_width=16

# Alternative: signed with the formal 7-tuple instead of a transition
#   '       ▼ q₀'
#   '┄┬─┬─┬─┬─┬─┬┄'
#   '┄┤0│1│1│0│1├┄'
#   '┄┴─┴─┴─┴─┴─┴┄'
#   '⟨Q,Γ,b,Σ,δ,q₀,F⟩'
#
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
    local fn mascot info line
    # consume the log registry — funcs run in the current shell, so exports
    # they make (e.g. SSH_AUTH_SOCK) persist in the session
    for fn in "${BANNER_LOG_FUNCS[@]}"; do
        (( $+functions[$fn] )) && $fn
    done
    rows=$(( ${#_banner_mascot} > ${#_banner_info_lines} \
             ? ${#_banner_mascot} : ${#_banner_info_lines} ))
    print
    for (( i = 1; i <= rows; i++ )); do
        mascot="${_banner_mascot[i]:-}"
        info="${_banner_info_lines[i]:-}"
        print -P -- "  %F{${BANNER_ACCENT:-yellow}}${(r:${_banner_mascot_width}:)mascot}%f   ${info}"
    done
    (( ${#_banner_log_lines} )) && print
    for line in "${_banner_log_lines[@]}"; do
        print -P -- "    %F{8}· ${line//\%/%%}%f"
    done
    print
    # consumed — a re-source/re-render starts clean
    _banner_info_lines=() _banner_log_lines=()
}
