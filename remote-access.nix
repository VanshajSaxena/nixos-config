{
  config,
  ...
}:

{
  # Reachability. Tailscale handles NAT traversal and the dynamic-IP problem,
  # so this machine is addressable from cellular without port forwarding or DDNS.
  services.tailscale = {
    enable = true;
    # Opens UDP 41641 for Tailscale's *own* traffic, which lets peers negotiate
    # a direct connection instead of relaying through DERP. This is unrelated
    # to SSH exposure -- see the firewall block below for that.
    openFirewall = true;
  };

  services.openssh = {
    enable = true;
    # Defaults to true, which would open TCP 22 on every network this laptop
    # joins. Reachability comes from trustedInterfaces below instead, so sshd
    # answers over the tailnet and is invisible everywhere else.
    openFirewall = false;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "vanshaj" ];
    };
  };

  users.users.vanshaj.openssh.authorizedKeys.keys = [
    # Phone (Termux). Generate the key there:
    #   pkg install openssh
    #   ssh-keygen -t ed25519 -C termux
    #   cat ~/.ssh/id_ed25519.pub
    # Paste the whole "ssh-ed25519 AAAA... termux" line here, then rebuild.
    # Until a key is listed, pubkey-only auth means nobody can log in.
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOXc9yBqhun5+c4k24qountB/tAaqxMugVcw3N7O6UN5 termux"
  ];

  # Roaming-tolerant shell: survives losing signal, Wi-Fi <-> cellular handoff,
  # and the phone sleeping, none of which a bare SSH session tolerates.
  programs.mosh = {
    enable = true;
    # Also defaults to true, which would open UDP 60000-61000 globally.
    openFirewall = false;
  };

  # The single rule that grants access: everything on the Tailscale interface
  # is trusted, nothing else is. Covers sshd and mosh's UDP range at once.
  networking.firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];

  # This laptop only supports s2idle -- there is no deep S3 -- so a suspended
  # machine drops off the tailnet entirely. Closing the lid on AC power now
  # keeps it awake and reachable; on battery it still suspends as before.
  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";
}
