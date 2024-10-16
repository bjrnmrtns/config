# Connect to wifi with nmcli
1. Show access points
```nmcli dev wifi list```
2. Connect to access point
```nmcli dev wifi connect {wifi-ssid} password {wifi-password}```

# NixOS command debugging
1. Where to search options
```https://home-manager-options.extranix.com/?query=aerc&release=master```

# NixOS debugging
1. If `home-manager-{user}` service fails to start then run
```sh
journalctl --unit home-manager-{user}.service
```

# gpg / pass key handling
1. Generete new gpg key
```gpg --full-generet-key```
2. Init pass with sub key id 
```pass git init {key-id}```
3. Add a key to pass for example mail/borjn@proton.me
```pass git insert mail/borjn@proton.me```
4. Show the key
```pass mail/borjn@proton.me```
4. Push pass keys to remote repo
```pass git push```

# gpg key handling
1. Check key-id list secret keys
```gpg --list-secret-keys```
2. Actual change passphrase
```gpg --edit-key {key-id}```
```passwd```
3. Backup private key (this includes subkeys and public keys)
```gpg --export-secret-keys --armor {key-id} > private-key-backup.asc```
4. Restore  private keys using backup
```gpg --import private-key-backup.asc```
