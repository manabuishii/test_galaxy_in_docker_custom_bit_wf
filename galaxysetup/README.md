# How to setup Galaxy environment

This script run galaxy with your account.


## Prepare Datadirectory

TODO

## Run

from your host

```
./run-container.sh
```

inside container

```
./setup_inside_container.sh
/usr/bin/startup
```

## Config

### SGE environment

If you test with SGE (Sun Grid Engine, Open Grid Scheduler, Univa, etc),
 you can use it with your account.


`SGEMASTERHOST` is SGE Master Host.
