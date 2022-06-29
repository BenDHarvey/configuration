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
      packer
      aws-sam-cli
      plantuml
      kubectl
      glow
      pandoc
      # Python stuff
      black
      # ruby
      rbenv
      vagrant
      argocd
      expect
      docker-compose
      openssl
      flyctl
    ];
  };
}
