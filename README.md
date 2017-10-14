# StudioSuperadmin

For linux release configure `distillery`, `prod.secret.exs` and run
```
./build.sh
scp ./_build/prod/rel/studio_superadmin/releases/0.0.1/studio_superadmin.tar.gz user@server:~/studio_superadmin/studio_superadmin.tar.gz
ssh user@server
cd ~/studio_superadmin/
tar xvfz ./studio_superadmin.tar.gz
./bin/studio_superadmin console
```
