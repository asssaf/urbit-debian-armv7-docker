# urbit-debian-armv7-docker
Container image for running [Urbit](https://urbit.org) on armv7 devices such as the Raspberry Pi.

The image is based on debian jessie so unfortunately not as light as alpine (it's about 120MB), but it
matches its intended host OS, [HypriotOS](https://github.com/hypriot/image-builder-rpi).

Includes an optional patch to limit memory to 512MB (delete `10-mem-512mb.patch` before building if you want the full 2048MB)

## Run
Create a comet
```
$ docker run -it --rm --net=host \
    -v $PWD:/urbit --user $(id -u):$(id -g) \
    asssaf/urbit-debian-armv7 -c comet
```
