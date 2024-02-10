# Todo
+ partition.sh script which is downloadable during NixOS configuration using curl
+ make partition.sh interactive so it can ask for disk to partition
+ check if nixos-generate-config is really needed, or we can get away with curl it from github
+ add  minimal configuration.nix and hardware-configuration.nix ( ssh access / git private repo access -> both without passwords)
+ for the above step we need a way to get public keys from other machines
- side-note not really todo -> every machine has its own private / public key pair, vaultwarden should only contain passphrases, but not if no two machines have access to another machine then private keys should be part of vaultwarden
- tap device on host machine for networking performance
+ check if root is allowed on ssh, it should not (should only usable with physical access) -> root is not allowed to login over ssh
- intalll/configure wireguard
- put keys in secrets repo gitolite encrypted and use age to decrypt
- install/impermancence -> make sure to exclude important dirs (.ssh?)
- put nixos-config in gitolite and mirror on github
- put all repos in gitolite and mirror public ones on github
- check howto handle home-manager in new config structure with modules and host configs
- check gitolite backup all repos

# Steps for implement boostrapping
 - create a host with agenix git gitolite (bare minimum)
   - backup old host-key (private/public)
   - partitioning
   - user gitolite is created with new public private keypair
   - public key is changed in gitolite.nix
   - all gitolite repos execpt gitolite-admin are restored
   - rebuild
   - gitolite-admin contents is restored except gitolite-admin key
   - rekey secrets with new host-key (restore old host-key private/public)
   - remove old host key private/public
   - get nixos-config and build full system, which now can use secrets

## Todo new laptop
- fix issue not typing magic keyboard and starting again -> lag
+ add bluetooth info on waybar
+ check if foot needs a bigger font size
x check if shutting down wifi/bluetooth after resume helps connectivity
+ let certain applications start on certain workspaces sway
+ fix waybar time (two times time)
- remove audio bluetooth from bluetooth part waybar
- have keys to alter audio and backlight
+ add idle config sway
- check when close lid -> idle config sway starts
- check why todo doesn't open
- check powersave off bluetooth helps lag keyboard magic apple
- get all data from other computer (bookkeepingstuff)
- try adding data to private git repo (bookkeepingstuff)
 
