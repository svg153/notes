# *`systemd`* 101 (by [@skgsergio](https://github.com/skgsergio))

- *`systemd`* / linux ... de todo lo que hace
- Gestor de servicios
- Kernel de linux init 1, binario que tiene que arrancar, el PID 1, es un gestor de procesos
  - antiguamente *`sysvinit`*

## unit types

- `.service`: services
- `.socket`: sockets based daemons activations
- `.target`: target units
- `.timer`: timers
- `.slice`: slice units
- `.device`: device units
- `.mount`: mount units
- `.automount`: on-demand and parallelized mount point of file systems
- `.swap`: swap units
- `.path`: path based daemons activations
- `.scope`: Special units created by systemd to control the activation of other units

## useful commands

Commands:

- `systemd-analyze plot` > /tmp/systemd-analyze.svg
- `coredumpctl`:
- `bootctl`: systemd bootloader (*`grub`*)
- `resolvctl`: name resolution manager
- `machinectl`: VM and container management (like *`runc`*)
- `oomctl`: manger userspace out of memory manager (OOM)

Other commands: `systemctl`, `hostnamectl`, `networkctl`, `homectl`, `loginctl`

## *`systemd`* timer vs *`cron`*

- No hacks in *`cron`*s
- Command to show the timers (jobs)
- *`systemd`* has logging in `journalctl`. Cron needs `send-main`
- Not complex for basic, but powerful compared to *`cron`*
