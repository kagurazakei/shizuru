{self, ...}: {
  formatter = self.lib.eachSystem ({zpkgs, ...}: zpkgs.irminsul);
}
