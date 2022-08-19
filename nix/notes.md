# Notes

Some notes from when setting up new nixos instance

- moved the existing configuration and hardware-configuration files into git repo
- setup symlink from ~/.configuration to /etc/nixos

```
ln -sf ~/.configuration/nix/machines/nixos-benpc/configuration.nix /etc/nixos/configuration.nix
ln -sf ~/.configuration/nix/machines/nixos-benpc/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
```
