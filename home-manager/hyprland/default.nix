{
  imports = builtins.map (modules: ./. + "/${modules}") (
    builtins.filter (x: x != "default.nix") (builtins.attrNames (builtins.readDir ./.))
  );

  services.swww = {
    enable = true;
  };

  services.dunst = {
    enable = true;
  };

  services.hyprpolkitagent = {
    enable = true;
  };
}
