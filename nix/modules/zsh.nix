{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableCompletion = false;
    shellAliases = {
      ls = "ls -las";
      emacs = "emacs -nw";
      gs = "git status";
      gl = "git log --decorate --graph";
      gd = "git diff";
      clean = "git clean -xdf";
      vim = "nvim";
      clear = "clear && ls";

      # Nix aliases
      nixre = "darwin-rebuild switch";
      nixrb = "darwin-rebuild --rollback";
      nixgc = "nix-collect-garbage -d";
      nixq = "nix-env -qaP";
      nixupgrade-darwin =
        "sudo -i sh -c 'nix-channel --update && nix-env -iA nixpkgs.nix && launchctl remove org.nixos.nix-daemon && launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist'";
      nixup = "nix-env -u";

      # Doom aliases
      doom-sync = "~/.emacs.d/bin/doom upgrade && ~/.emacs.d/bin/doom sync";

      # rqp
      rqp = "~/apps/rqp";
    };

    profileExtra = ''
      export GPG_TTY=$(tty)
      if ! pgrep -x "gpg-agent" > /dev/null; then
          ${pkgs.gnupg}/bin/gpgconf --launch gpg-agent
      fi

      export PATH=/opt/homebrew/bin:$PATH

    '';

    initExtra = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

      bindkey '^ ' autosuggest-accept
      AGKOZAK_CMD_EXEC_TIME=5
      AGKOZAK_COLORS_CMD_EXEC_TIME='yellow'
      AGKOZAK_COLORS_PROMPT_CHAR='magenta'
      AGKOZAK_CUSTOM_SYMBOLS=( '⇣⇡' '⇣' '⇡' '+' 'x' '!' '>' '?' )
      AGKOZAK_MULTILINE=0
      AGKOZAK_PROMPT_CHAR=( ❯ ❯ ❮ )
      autopair-init

      dockerNuke() {
        docker stop $(docker ps -a -q)
        docker system prune -a -f
        docker volume prune -f
        docker network prune -f
      }

      dockerClean() {
        docker stop $(docker ps -a -q)
        docker volume prune -f
      }

      update() {
        sudo apt update && sudo apt upgrade -y
      }

      ksauth () {
        auth -s kaos -r poweruser -z sercure
      }

      auth () {
        rqp auth -e ben.harvey@nib.com.au $@
      }

      ## zsh-vim-mode config
      ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
      ## Allow fzf to still work with vi-mode
      # Define an init function and append to zvm_after_init_commands
      function vi_mode_init() {
        [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
      }
      zvm_after_init_commands+=(vi_mode_init)
      eval "$(zoxide init zsh)"

      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
      [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
                              '';

    plugins = with pkgs; [
      {
        name = "agkozak-zsh-prompt";
        src = fetchFromGitHub {
          owner = "agkozak";
          repo = "agkozak-zsh-prompt";
          rev = "v3.7.0";
          sha256 = "1iz4l8777i52gfynzpf6yybrmics8g4i3f1xs3rqsr40bb89igrs";
        };
        file = "agkozak-zsh-prompt.plugin.zsh";
      }
      {
        name = "formarks";
        src = fetchFromGitHub {
          owner = "wfxr";
          repo = "formarks";
          rev = "8abce138218a8e6acd3c8ad2dd52550198625944";
          sha256 = "1wr4ypv2b6a2w9qsia29mb36xf98zjzhp3bq4ix6r3cmra3xij90";
        };
        file = "formarks.plugin.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.6.0";
          sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
        };
        file = "zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-abbrev-alias";
        src = fetchFromGitHub {
          owner = "momo-lab";
          repo = "zsh-abbrev-alias";
          rev = "637f0b2dda6d392bf710190ee472a48a20766c07";
          sha256 = "16saanmwpp634yc8jfdxig0ivm1gvcgpif937gbdxf0csc6vh47k";
        };
        file = "abbrev-alias.plugin.zsh";
      }
      {
        name = "zsh-autopair";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
          sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
        };
        file = "autopair.zsh";
      }
    ];
  };
}
