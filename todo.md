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
