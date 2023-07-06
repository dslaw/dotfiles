function openvpn-start
    set -l location $argv[1]

    if not string length --quiet $location
        set -f location us_california
    end

    set -l authfile $HOME/Scripts/openvpn-pia-creds.txt
    sudo openvpn --cd /etc/openvpn --config $location.ovpn --auth-user-pass $authfile
end
