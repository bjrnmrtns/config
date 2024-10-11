# Connect to wifi with nmcli
1. Show access points
```nmcli dev wifi list```
2. Connect to access point
```nmcli dev wifi connect {wifi-ssid} password {wifi-password}```

# NixOS command debugging
1. Where to search options
```https://home-manager-options.extranix.com/?query=aerc&release=master```

# Setup pass and gpg for aerc
```sh
gpg --full-generate-key
pass init "borjn@proton.me"
gpg --edit-key {key}
trust
save
pass insert aerc/bjorn@expeditious.nl"
```

# NixOS debugging
1. If `home-manager-{user}` service fails to start then run
```sh
journalctl --unit home-manager-{user}.service
```
