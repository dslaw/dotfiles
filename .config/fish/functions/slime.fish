function slime --description "Start a slime session"
  tmux -L $argv[1] new-session -s slime $argv[2..-1]
end
