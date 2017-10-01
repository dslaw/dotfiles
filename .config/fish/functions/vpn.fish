function vpn
  sudo openvpn --config "/etc/openvpn/$argv[1].ovpn" \
    --auth-user-pass "/etc/openvpn/pia.txt" \
    --ca "/etc/openvpn/ca.rsa.2048.crt" \
    --crl-verify "/etc/openvpn/crl.rsa.2048.pem"
end
