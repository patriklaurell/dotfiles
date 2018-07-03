alias redwm "cd ~/dwm; make; sudo make install; make clean; killall dwm;"
alias s "systemctl suspend"
alias md "mkdir"
alias rd "rmdir"
alias xc "xclip -selection clipboard"
alias xp "xclip -o -selection clipboard"

if not set -q abbrs_initialized
  set -U abbrs_initialized
  echo -n Setting abbreviations... 

  abbr ga 'git add'
  abbr gc 'git commit'
  abbr gco 'git checkout'
  abbr gd 'git diff'
  abbr gf 'git fetch'
  abbr gl 'git log'
  abbr gm 'git merge'
  abbr gp 'git pull'
  abbr gr 'git remote'
  abbr gs 'git status'

  echo 'Done'
end


# fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

# Status Chars
set __fish_git_prompt_char_dirtystate '*'
set __fish_git_prompt_char_stagedstate '?'
set __fish_git_prompt_char_stashstate '?'
set __fish_git_prompt_char_upstream_ahead '?'
set __fish_git_prompt_char_upstream_behind '?'

function fish_prompt
        set last_status  $status
        set_color $fish_color_cwd
        printf '%s' (prompt_pwd)
        set_color normal
        printf '%s ' (__fish_git_prompt)
        set_color normal
end

function !!
  eval $history[1]
end
