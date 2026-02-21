use git-status.nu
zoxide init nushell | save -f ~/.config/nushell/.zoxide.nu
source ~/.config/nushell/.zoxide.nu
carapace _carapace nushell | save -f ~/.config/nushell/carapace.nu
source $"($nu.cache-dir)/carapace.nu"
source $"($nu.cache-dir)/atuin.nu"
use $"($nu.cache-dir)/nix-your-shell.nu"
source ~/.config/nushell/carapace.nu
# Environment Variables
$env.config.show_banner = false
$env.PATH = ($env.PATH | prepend [
    $"($env.HOME)/bin",
    $"($env.HOME)/.local/bin",
    "/usr/local/bin",
    $"($env.HOME)/.cargo/bin",
    $"($env.HOME)/.nix-profile/bin"
])

if ($env.IN_NIX_SHELL? | is-not-empty) {
    print "⚠️  nix-shell detected: sudo will NOT work here"
}

$env.EDITOR = "nvim"
$env.MANPAGER = "nvim +Man!"

$env.config.buffer_editor = "nvim"

# FZF Configuration
$env.FZF_CTRL_T_COMMAND = "exa --icons"
$env.FZF_CTRL_T_OPTS = "--accept-nth=2"
$env.FZF_CTRL_R_OPTS = "--with-nth=2,-1"
$env.FZF_DEFAULT_OPTS = (
    "--height 40% --history-size=10000000000 " +
    "--layout=reverse --border=rounded --exact --cycle --wrap " +
    $"--history=($env.HOME)/.zsh_history " +
    "--color=bg:#00070B,bg+:#000f12,fg:#A9A9A9,fg+:#A9A9A9 " +
    "--color=hl:#F26E74,hl+:#F26E74 " +
    "--color=info:#79AAEB,prompt:#E9967E,pointer:#C488EC " +
    "--color=marker:#78B892,spinner:#78B892 " +
    "--color=border:#E89982"
)

# Prompt Configuration

$env.PROMPT_COMMAND_RIGHT = ""
$env.PROMPT_COMMAND = {
    # Hex to RGB conversions
    let brack_hex = "\e[38;2;83;89;95m"    # #53595f
    let user_hex = "\e[38;2;120;184;146m"  # #78B892
    let at_hex = "\e[38;2;201;147;138m"    # #c9938a
    let host_hex = "\e[38;2;196;136;236m"  # #C488EC
    let cwd_hex = "\e[38;2;103;145;201m"   # #6791C9
    let uid_hex = "\e[38;2;242;110;116m"   # #F26E74
    let reset = "\e[0m"

    let username = $env.USER
    let hostname = (hostname | str trim)
    let cwd = $env.PWD | str replace $env.HOME "~"
    let uid = if (id -u) == 0 { "#" } else { "$" }

    $"($brack_hex)[($user_hex)($username)($at_hex)@($host_hex)($hostname) ($cwd_hex)($cwd)($brack_hex)](git-status)($uid_hex)($uid)($reset)"
}

# aliases

def nls [...args] {
  hide ls;
  if ($args | is-empty) {
    ls
  } else { ls ...$args }
}

# alias ls = exa --icons --git
# alias ll = exa -h --git --icons -l
# alias l = exa -h --git --icons -l
# alias la = exa -h --git --icons -la
# alias lt = exa -h --tree --git --icons -l
# alias lta = exa -h --tree --git --icons -la
alias ll = ls -l
alias l = ls -l
alias la = ls -la
alias ldt = lsd --tree
alias lt = g --tree-style=unicode
alias grep = grep --color=always
alias objdump = objdump --disassembler-color=on --visualize-jumps=extended-color
alias b64 = base64
alias cb = cargo build
alias cr = cargo run
alias v = nvim
alias sv = sudo -E nvim
alias fm = yazi
alias e = clear
alias x = exit
alias gcl = git clone
alias cn = cd ~/shizuru
alias cd = z
alias  listgen = sudo nix-env -p /nix/var/nix/profiles/system --list-generations
alias fuck = nh os switch --hostname hana
alias rebuild = sudo nixos-rebuild switch --flake .#hana
alias fucku = nh os switch --hostname hana --update
alias clean-gc = nh clean all --keep 3
alias ga = git add .
alias lg = lazygit
alias nf = nitch
alias ff = fastfetch
alias cp = cp -r
alias rm = rm -rf
alias spf = superfile
alias v = nvim 
alias sv = sudo -E nvim 
# Custom Functions
## def sshot [delay: int] {
##     sleep ($delay | into duration --unit sec)
##     grim $"($env.HOME)/Pictures/p.png"
##     cat $"($env.HOME)/Pictures/p.png" | wl-copy
## }
##
## def shot [delay: int] {
##     sleep ($delay | into duration --unit sec)
##     grim -g (slurp) $"($env.HOME)/Pictures/p.png"
##     cat $"($env.HOME)/Pictures/p.png" | wl-copy
## }

# Fixed aliases as Functions
alias gst = git status
alias gp = git push
alias ga = git add .
def gac [message: string] {
    git add .
    git commit -m $message
}

def iamb [] {
    with-env { EDITOR: "nvim" } { iamb }
}

starship init nu | save -f ~/.cache/starship/init.nu
use ~/.cache/starship/init.nu
krabby random
