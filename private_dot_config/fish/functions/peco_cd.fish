function peco_cd
  set selected_dir (ghq list -p | peco)
  if [ $selected_dir ]
    cd $selected_dir
    commandline -f repaint
  end
end
