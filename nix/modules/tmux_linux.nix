# Tmux config with some mac specific additions
{ config, lib, pkgs, ... }:

{
  programs = {
    tmux = {
      enable = true;
      tmuxp.enable = true;
      historyLimit = 500000;
      extraConfig = ''
        unbind C-b
        set -g prefix `
        bind-key ` send-prefix

        setw -g mouse on
        setw -g mode-keys vi

        set -g @scroll-speed-num-lines-per-scroll 1

        set -g status-interval 60
        set -g status off
        setw -g monitor-activity off
        set -g visual-activity on
        #
        ## Quick window selection
        bind -r C-h select-window -t :-
        bind -r C-l select-window -t :+
        bind -r C-s set -g status
        #
        set-option -ga terminal-overrides ",xterm-256color:Tc"
        #set-option -g default-shell /usr/bin/zsh
        ## Default terminal is 256 colors
        set -g default-terminal "screen-256color"
        #
        unbind c
        unbind '"'
        unbind %
        bind '"' split-window -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R
        #
        bind -r H resize-pane -L 5
        bind -r J resize-pane -D 5
        bind -r K resize-pane -U 5
        bind -r L resize-pane -R 5
        #
        set -g @plugin 'tmux-plugins/tpm'
        set -g @plugin 'nhdaly/tmux-better-mouse-mode'
        set -g @plugin 'tmux-plugins/tmux-sensible'
        set -g @plugin 'tmux-plugins/tmux-yank'
        #
        run '~/.tmux/plugins/tpm/tpm'
        #
      '';
    };
  };
}
