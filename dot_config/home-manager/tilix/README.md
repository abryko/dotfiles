# How to fetch current config from Tilix

```
tmpfile="$(mktemp -u -t tilix-XXXXXX.conf)"
dconf dump /com/gexperts/Tilix/ > "${tmpfile}"
dconf2nix -i "${tmpfile}" -o default.nix -r com/gexperts/Tilix
```
