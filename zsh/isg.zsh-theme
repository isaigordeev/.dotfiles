#
# isg ZSH Theme
#
# Forked from Sobole ZSH Theme by Nikita Sobolev (github.com/sobolevn)
# Original: https://github.com/sobolevn/sobole-zsh-theme
# License: WTFPL

# Testing colors:
#
# for i in {0..255} ; do
#   printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
#   if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
#     printf "\n";
#   fi
# done

# ----------------------------------------------------------------------------
# PROMPT settings
# These settings changes how your terminal prompt looks like
# ----------------------------------------------------------------------------

PROMPT='$(__isg::current_venv)$(__isg::user_info)$(__isg::current_dir) $(git_prompt_info)
$(__isg::current_caret) '

PROMPT2='. '

_return_status="%(?..%{$fg[red]%}%? ⚠️%{$reset_color%})"

RPROMPT='%{$(echotc UP 1)%} ${_return_status}%{$(echotc DO 1)%}'

__isg::current_caret () {
  # This function sets caret color and sign
  # based on theme and privileges.
  if [[ "$USER" == 'root' ]] || [[ "$(id -u "$USER")" == 0 ]]; then
    CARET_COLOR='red'
    CARET_SIGN='#'
  else
    CARET_SIGN='»'

    if [[ "$ISG_THEME_MODE" == 'dark' ]]; then
      CARET_COLOR='white'
    else
      CARET_COLOR='black'
    fi
  fi

  echo "%{$fg[$CARET_COLOR]%}$CARET_SIGN%{$reset_color%}"
}

__isg::current_dir () {
  # Settings up current directory and settings max width for it:
  local max_pwd_length="${ISG_MAX_DIR_LEN:-65}"
  local color

  if [[ "$ISG_THEME_MODE" == 'dark' ]]; then
    color='white'
  else
    color='blue'
  fi

  if [[ $(echo -n "$PWD" | wc -c) -gt "$max_pwd_length" ]]; then
    echo "%{$fg_bold[$color]%}%-1~ ... %2~%{$reset_color%} "
  else
    echo "%{$fg_bold[$color]%}%~%{$reset_color%} "
  fi
}

__isg::user_info () {
  if [[ -n "$SSH_TTY" ]] || [[ -n "$SSH_CONNECTION" ]]; then
    echo "$fg[green]#$reset_color$USER "
  elif [[ ! -z "$ISG_DEFAULT_USER" ]] &&
     [[ "$USER" != "$ISG_DEFAULT_USER" ]]; then
    echo "@$USER "
  fi
}

# ----------------------------------------------------------------------------
# virtualenv settings
# These settings changes how virtualenv is displayed.
# ----------------------------------------------------------------------------

# Disable the standard prompt:
export VIRTUAL_ENV_DISABLE_PROMPT=1

__isg::current_venv () {
  # Despite the fact that `_OLD_VIRTUAL_PATH` is undocumented, it is always
  # set in `activate` script. It is needed to fix `vscode` terminal.
  if [[ ! -z "$VIRTUAL_ENV" ]] && [[ ! -z "$_OLD_VIRTUAL_PATH" ]]; then
    # Show this info only if virtualenv is activated:
    local dir=$(basename "$VIRTUAL_ENV")
    echo "($dir) "
  fi
}

# ----------------------------------------------------------------------------
# VCS specific colors and icons
# These settings defines how icons and text is displayed for
# vcs-related stuff. We support only `git`.
# ----------------------------------------------------------------------------

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚%{$reset_color%}"

# ----------------------------------------------------------------------------
# `ls` colors
# Made with: http://geoff.greer.fm/lscolors/
# ----------------------------------------------------------------------------

if [[ "$ISG_THEME_MODE" == 'dark' ]]; then
  export LSCOLORS='gxfxcxdxbxegedabagacad'
  export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
else
  export LSCOLORS='exfxcxdxBxegedabagacab'
  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=1;31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;41'
fi

# Turns on colors with default unix `ls` command:
export CLICOLOR=1

# ----------------------------------------------------------------------------
# `grep` colors and options
# ----------------------------------------------------------------------------

export GREP_COLORS='mt=1;35'

# ----------------------------------------------------------------------------
# `zstyle` colors
# Internal zsh styles: completions, suggestions, etc
# ----------------------------------------------------------------------------

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'

# ----------------------------------------------------------------------------
# zsh-syntax-highlighting, fzf, and bat tweaks
# This setting works only if `$ISG_SYNTAX_HIGHLIGHTING` is not false.
# Each tool is only modified if installed.
# ----------------------------------------------------------------------------

if [[ "$ISG_SYNTAX_HIGHLIGHTING" != 'false' ]]; then
  typeset -A ZSH_HIGHLIGHT_STYLES

  # Disable strings highlighting:
  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='none'
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='none'

  if [[ "$ISG_THEME_MODE" == 'dark' ]]; then
    ZSH_HIGHLIGHT_STYLES[path]='fg=white,underline'
  fi

  if [[ "$ISG_THEME_MODE" == 'dark' ]]; then
    export ISG_SYNTAX_THEME="${ISG_SYNTAX_THEME_LIGHT:-base16-256}"
  else
    export ISG_SYNTAX_THEME="${ISG_SYNTAX_THEME_LIGHT:-Monokai Extended Light}"
  fi

  # If `bat` is installed, then change the theme for it:
  # https://github.com/sharkdp/bat
  if (( $+commands[bat] )); then
    export BAT_THEME="$ISG_SYNTAX_THEME"
  fi
fi

# ----------------------------------------------------------------------------
# fzf and fzf-tab tweaks.
# See:
# - https://github.com/junegunn/fzf
# - https://github.com/Aloxaf/fzf-tab
# ----------------------------------------------------------------------------

if [[ "$ISG_FZF_THEME" != 'false' ]]; then
  if (( $+commands[fzf] )); then
    # This theme is the same for both light and dark themes:
    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS
      --color=bg:-1,fg:-1,bg+:#dce7f2,fg+:bright-black
      --color=hl:bright-blue,hl+:blue
      --color=header:green,info:green,pointer:blue
      --color=marker:bright-blue,prompt:black,spinner:blue"

    # fzf-tab theme, setting the default color for suggestions (blue for me)
    # Test all colors: `msgcat --color=test`
    zstyle ':fzf-tab:*' default-color $'\x1b[30m'

    # Matched text highlight
    local fzf_flags
    fzf_flags=( '--color=hl:bright-blue' )
    zstyle ':fzf-tab:*' fzf-flags $fzf_flags
  fi
fi

# ----------------------------------------------------------------------------
# less (and man) colors
# ----------------------------------------------------------------------------

if [[ "$ISG_LESS_THEME" != 'false' ]]; then
  if [[ "$ISG_THEME_MODE" == 'dark' ]]; then
    export LESS_TERMCAP_mb="$(printf '\e[1;35m')"
    export LESS_TERMCAP_md="$(printf '\e[1;35m')"
  else
    export LESS_TERMCAP_mb="$(printf '\e[1;34m')"
    export LESS_TERMCAP_md="$(printf '\e[1;34m')"
  fi
  export LESS_TERMCAP_me="$(printf '\e[0m')"
  export LESS_TERMCAP_se=$(printf '\e[0m')
  export LESS_TERMCAP_so=$(printf '\e[30m')
  export LESS_TERMCAP_ue=$(printf '\e[0m')
  export LESS_TERMCAP_us=$(printf '\e[1;32m')
fi

# ----------------------------------------------------------------------------
# zsh hooks
# ----------------------------------------------------------------------------

_ISG_ADD_LINE_SEPARATOR='false'

__isg::preexec () {
  if [[ $# -eq 0 ]] || [[ "$2" == 'clear' ]]; then
    _ISG_ADD_LINE_SEPARATOR='false'
  else
    _ISG_ADD_LINE_SEPARATOR='true'
  fi
}

__isg::precmd () {
  local cmd_result="$?"
  if [[ "$_ISG_ADD_LINE_SEPARATOR" == 'true' ]] ||
     [[ "$cmd_result" -ne 0 ]]; then
    print
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec __isg::preexec
add-zsh-hook precmd __isg::precmd

# ----------------------------------------------------------------------------
# startup banner: mascot · status lines · quiet logs
#
#          ▼ q₀        isg · zsh
#   ┄┬─┬─┬─┬─┬─┬┄      Wed 11 Jun 2026 · 20:42
#   ┄┤0│1│1│0│1├┄      ~/.dotfiles · main
#   ┄┴─┴─┴─┴─┴─┴┄
#   δ(q₀,0)=⟨B,1,R⟩
#
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
# ----------------------------------------------------------------------------

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

# ── toy: the beaver lives through the week ──
# Each day the machine is ⌊14·d/6⌋ steps into its run (d = 0 on Monday):
# Mon 0 · Tue 2 · Wed 4 · Thu 7 · Fri 9 · Sat 11 · Sun 14 — on Sunday δ
# is undefined and it rests in HALT ∈ F, tape full of 1s. The static
# array above is Monday's step zero (q₀ = qA); this overwrites it with
# today's frame: simulated tape window around the head, current state,
# and the pending transition (HALT abbreviated H in the triple).
__isg::beaver_mascot() {
    local -i steps=$1 head=0 i
    local state=A sym label move
    local -a rule cells
    local -A tape
    local -A delta=(
        A0 '1 R B'   A1 '1 L C'
        B0 '1 L A'   B1 '1 R B'
        C0 '1 L B'   C1 '1 R HALT'
    )
    for (( i = 0; i < steps; i++ )); do
        sym=${tape[$head]:-0}
        rule=( ${=delta[${state}${sym}]} )
        (( ${#rule} )) || break
        tape[$head]=$rule[1]
        if [[ $rule[2] == R ]]; then (( head++ )); else (( head-- )); fi
        state=$rule[3]
    done
    for i in {-2..2}; do
        cells+=( "${tape[$(( head + i ))]:-0}" )
    done
    sym=${tape[$head]:-0}
    rule=( ${=delta[${state}${sym}]} )
    label="q$state"; [[ $state == HALT ]] && label='HALT'
    if (( ${#rule} )); then
        move="δ($label,$sym)=⟨${rule[3]/HALT/H},$rule[1],$rule[2]⟩"
    else
        move="δ($label,·) = ∅ ∎"
    fi
    _banner_mascot=(
        "       ▼ $label"
        '┄┬─┬─┬─┬─┬─┬┄'
        "┄┤$cells[1]│$cells[2]│$cells[3]│$cells[4]│$cells[5]├┄"
        '┄┴─┴─┴─┴─┴─┴┄'
        "$move"
    )
}

if zmodload zsh/datetime 2>/dev/null; then
    strftime -s _isg_dow '%u' $EPOCHSECONDS   # 1 = Monday .. 7 = Sunday
    __isg::beaver_mascot $(( 14 * (_isg_dow - 1) / 6 ))
    unset _isg_dow
fi

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
