{ secrets, ... }: {
  # Add a repos by cloning ssh:://gitolite@<server>/gitolite-admin and add the repo in conf/gitolite.conf 
  services.gitolite = {
    enable = true;
    adminPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFDl2Q6uuIdgeFU24JDj19YzTufS44HUqNDY+mdsmh04 bjorn@mcfly";
  };
}

