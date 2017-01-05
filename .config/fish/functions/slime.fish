function slime --description "Start a slime session"
  set -l args
  if test (count $argv) -gt 1
    set args $argv[2..-1]
  end

  tmux -L $argv[1] new-session -s slime $args
end
