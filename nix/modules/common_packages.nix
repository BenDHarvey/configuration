{ config, lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      tmux
      git
      xclip
      jq
      wget
      ripgrep
      fd
      htop
      terraform
      awscli
      docker-compose
      ranger
      tree
      rsync
      neovim
      gh
      act
      yq
      unixtools.watch
      sops
      k9s
      kubernetes-helm
      coreutils
      clang
      cmake
      ffmpeg
      nmap
      fluxcd
      tmuxinator
      postgresql

      kubectl
      glow
      pandoc
    ];
  };
}
