function _is_remote
  test -n "$SSH_CLIENT";
  or test -n "$SSH_TTY";
  or test -n "$SSH_CONNECTION"
end

function check_ssh
  if _is_remote
    echo "SSH"
  end
end
