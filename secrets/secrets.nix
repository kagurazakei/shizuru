let
  hana = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEaNh2GVxWz2zLxDa8cMnPtfYQPk1A3xlKKVuKOTNrp2 antonio@hana"
    "age198s694ujjncgae5gctk7x8tcw746nkr39tqj6wg5k2uh8r8a237qnnwgkz"
    "age1nn2vewqrej5sn9lqkh3sf0slgj7cemmlre03l286vx9cu59k9u9qsyttcd"
  ];
  laptop = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjywfRHVDeBQBFYZym/c3JDVRwni//tSy5FPKmTgLyN antonio@hana"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBZ/2mQLJkKdNyfUvXI4KTneGLe6i7WXk+7Kl6ceeA7j maotsugiri@gmail.com"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDT989Rm6vSVS4cSP2NevoXVS7UnFVYHgfsE6dbM2+s6 hana@antonio"
  ];
in
{
  "laptop1.age".publicKeys = laptop;
  "laptop2.age".publicKeys = laptop;
  "laptop3.age".publicKeys = laptop;
  "github.age".publicKeys = hana;
  "secret4.age".publicKeys = laptop;
  "secret5.age".publicKeys = laptop;
  "secret6.age".publicKeys = laptop;
  "secret7.age".publicKeys = laptop;
  "secret8.age".publicKeys = laptop;
  "secret9.age".publicKeys = laptop;
  "anilist.age".publicKeys = laptop ++ hana;
  "recovery.age".publicKeys = laptop ++ hana;
}
