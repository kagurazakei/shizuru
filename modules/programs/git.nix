{
  azalea.modules.git = {config, ...}: {
    hj.rum.programs = {
      git = {
        enable = true;
        settings = {
          user = {
            name = "kagurazakei";
            email = "maotsugiri@gmail.com";
            signingKey = config.age.secrets.ssh-hana.path;
          };
        };
      };
    };
  };
}
