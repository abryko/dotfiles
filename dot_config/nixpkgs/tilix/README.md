# How to fetch current config from Tilix
```
dconf dump /com/gexperts/Tilix/ > tilix.conf
dconf2nix -i tilix.conf -o default.nix -r com/gexperts/Tilix
```


