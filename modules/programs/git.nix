{
  azalea.modules.git = {config, ...}: let
    hanaKey = config.services.openssh.knownHosts.hana.publicKey;
    kaguraKey = config.services.openssh.knownHosts.kagura.publicKey;
    signKey =
      if config.networking.hostName == "hana"
      then hanaKey
      else if config.networking.hostName == "kagura"
      then kaguraKey
      else null;
  in {
    hj.rum.programs.git = {
      enable = true;
      settings = {
        user = {
          name = "kagurazakei";
          email = "maotsugiri@gmail.com";
          signingKey = signKey;
        };
      };
    };
  };
}
