# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red
 
# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '☡'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'

function peco_select_ghq_repository
  set -l query (commandline)

  if test -n $query
    set peco_flags --query "$query"
  end

  # find $(ghq root)/*/* -type d -prune | sed -e 's#'$(ghq root)'/##' | peco $peco_flags | read line
  find $(ghq root)/* -type d -prune | sed -e 's#'$(ghq root)'/##' | peco $peco_flags | read line

  if [ $line ]
    cd $(ghq root)/$line
    commandline -f repaint
  end
end

bind \cr peco_select_ghq_repository

# Cursor
function cursor
    # Start the Cursor AppImage in the background, suppressing output
    nohup ~/Applications/cursor-0.43.6-build-241206z7j6me2e2-x86_64.AppImage $argv --no-sandbox > /dev/null 2>&1 &
end

# Hub
eval (hub alias -s)
