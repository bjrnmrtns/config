{ config, pkgs, lib, ... }: {
  config.services.gitea = {
    enable = true;
    appName = "git @ home";
    database.type = "sqlite3";

    settings = {
      server = {
        HTTP_ADDR = "192.168.1.59";
        SSH_PORT = 2222;
        ROOT_URL = "http://192.168.1.59/";
      };
      service.DISABLE_REGISTRATION = true;
      session.COOKIE_SECURE = true;
    };
  };

  config.networking.firewall = {
    allowedTCPPorts = [ 3000 ];
  };

#  config.services.nginx.enable = true;
#  config.services.nginx.virtualHosts."192.168.1.59" = {
#    locations."/" = {
#      proxyPass = "${config.services.gitea.settings.server.HTTP_ADDR}:${toString config.services.gitea.settings.server.HTTP_PORT}";
#    };
#  };
}
