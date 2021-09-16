# systemd 101 (by @skgsergio)

systemd / linux de todo lo que hace
gestor de servicios
kernel de linux init 1, binario que tiene que arracar, el PID 1, el PID1 es un gestior de procesos

- antiguamente sysvinit

## unit types

.service: services
.socket: sockets based daemons activations
.target: target units

.timer: timers

.slice: slice units

.device: device units
.mount: mount units
.automount: on-demand and parallelized mount point of file systems
.swap: swap units
.path: path based daemons activations

.scope: Special units created by systemd to control the activation of other units

## useful commands

Commands:

- systemd-analyze plot > /tmp/systemd-analyze.svg
- coredumpctl:
- bootctl: systemd bootloader (grub)
- resolvctl: name resolution manager
- machinectl: VM and container management (like runc)
- oomctl: manger serspace out of memory manager (OOM)
  Other commands: systemctl, hostnamectl, networkctl, homectl, loginctl

## systemd timer vs cron

- no hacks in cron
- command to show the timers (jobs)
- systemd has logging in journalctl. Cron needs send-main
- Not complex for basic, but powerfull compared to cron
