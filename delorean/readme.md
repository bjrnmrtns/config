# delorean is the vpn entry for the homelab

## Installation
sudo apt-get install --no-install-recommends git vim wireguard iptables wireguard-tools avahi-daemon avahi-utils qrencode

## Configuration
Generate keys for client and server:
wg genkey | tee wg-client0-private-key | wg pubkey > wg-client0-public-key
wg genkey | tee wg-client1-private-key | wg pubkey > wg-client1-public-key
wg genkey | tee wg-server-private-key | wg pubkey > wg-server-public-key

Fill in public private keys in wg0-client.conf and wg0-server.conf.
Copy wg0-client.conf to /etc/wireguard/wg0.conf on the client
Copy wg1-client.conf to /etc/wireguard/wg0.conf on the client
Copy wg0-server.conf to /etc/wireguard/wg0.conf on the server

If the client is iOS with qr reader, convert wg1-client.conf using qrencode:
qrencode -t ansiutf8 -r wg1-client.conf
and now import with camera on iOS client

On the server type:
wg-quick up wg0
sysctl -w net.ipv4.ip_forward=1

On the client type:
wg-quick up wg0
