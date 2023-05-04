# How to fetch current config from Tilix

```
tmpfile="$(mktemp -u -t gnome-terminal-XXXXXX.conf)"
dconf dump /org/gnome/terminal/legacy/ > "${tmpfile}"
dconf2nix -i "${tmpfile}" -o default.nix -r org/gnome/terminal/legacy
```
