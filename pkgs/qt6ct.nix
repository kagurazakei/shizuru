{pkgs}:
pkgs.qt6Packages.qt6ct.overrideAttrs (oldAttrs: {
  buildInputs =
    oldAttrs.buildInputs
    ++ [
      pkgs.qt6.qtdeclarative
      pkgs.kdePackages.kconfig
      pkgs.kdePackages.kcolorscheme
      pkgs.kdePackages.kiconthemes
    ];

  patches = [
    (pkgs.fetchpatch {
      url = "https://raw.githubusercontent.com/ilya-fedin/nur-repository/38a6ad7f0a671fc14dc2776631ef17c85a2d6221/pkgs/qt6ct/qt6ct-shenanigans.patch";
      hash = "sha256-quoWSRoTnsmiSXS/iOeGEAQUfg7G6chl+K45rkN0bsE=";
    })
  ];
})
