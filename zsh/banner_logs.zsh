# banner_logs.zsh — the dim log lines below the banner, one func each
#
# Registry: funcs run top-to-bottom when banner_render is called.
# Each func holds one log message — it calls banner_log "text", and may
# do the work that produces it (banner_run demotes noisy commands).
# Add a func below and list it here; remove a line to silence it.

BANNER_LOG_FUNCS=(
    log_shell
    log_remote
    # log_tmux
    log_start
)

log_shell() { banner_log "zsh $ZSH_VERSION · ${HOST%%.*}" }

log_remote() {
    if [[ -n $SSH_CONNECTION || -n $SSH_TTY ]]; then
        banner_log "session · ssh from ${SSH_CONNECTION%% *}"
    else
        banner_log "session · local"
    fi
}

# tmux, one minimal line — inside: current session · clients · detached;
# outside: counts only, silent when the server is idle or absent
log_tmux() {
    (( $+commands[tmux] )) || return 0
    local -a detached clients seg
    detached=( ${(f)"$(command tmux list-sessions \
        -F '#{?session_attached,,#{session_name}}' 2>/dev/null)"} )
    clients=( ${(f)"$(command tmux list-clients -F x 2>/dev/null)"} )
    [[ -n $TMUX ]] && seg+=("$(command tmux display-message -p '#S' 2>/dev/null)")
    local cs="clients"; (( ${#clients} == 1 )) && cs="client"
    (( ${#clients} ))  && seg+=("${#clients} $cs")
    (( ${#detached} )) && seg+=("${#detached} detached")
    (( ${#seg} )) || return 0
    banner_log "tmux · ${(j: · :)seg}"
}

# zshrc start (_BANNER_T0, stamped on .zshrc line 1) → banner render
log_start() {
    [[ -n $_BANNER_T0 ]] || return 0
    local -i ms=$(( (EPOCHREALTIME - _BANNER_T0) * 1000 ))
    banner_log "start · ${ms} ms"
}

# ssh-agent: reuse a reachable agent, add the key only if missing —
# was a noisy "Agent pid" / "Identity added" popping on every shell
log_ssh() {
    local key=~/.ssh/delos-new fp
    ssh-add -l &>/dev/null
    if (( $? == 2 )); then              # no agent reachable → start one
        eval "$(ssh-agent -s)" >/dev/null
        banner_log "ssh-agent started · pid $SSH_AGENT_PID"
    fi
    [[ -f $key.pub ]] && fp=$(ssh-keygen -lf $key.pub 2>/dev/null | awk '{print $2}')
    if [[ -n $fp ]] && ssh-add -l 2>/dev/null | command grep -qF "$fp"; then
        banner_log "ssh · delos-new ✓"
    else
        banner_run ssh-add $key
    fi
}
