{
  azalea.modules.adb = {
    programs.adb.enable = true;
    users.users.antonio.extraGroups = ["adbusers" "kvm"];
  };
}
