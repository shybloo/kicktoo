part sda 1 83 100M
part sda 2 82 2048M
part sda 3 83 +

format /dev/sda1 ext2
format /dev/sda2 swap
format /dev/sda3 ext4

mountfs /dev/sda1 ext2 /boot
mountfs /dev/sda2 swap
mountfs /dev/sda3 ext4 / noatime

stage_uri               ftp://mirrors.kernel.org/gentoo/releases/x86/autobuilds/20110705/stage3-i486-20110705.tar.bz2
tree_type               snapshot ftp://mirrors.kernel.org/gentoo/snapshots/portage-latest.tar.xz
kernel_config_file      /dotconfig
kernel_sources	        gentoo-sources
timezone                UTC
rootpw                  a
bootloader              grub
keymap	                be-latin1 # fr en
hostname                gentoo
#extra_packages          openssh vixie-cron syslog-ng
#rcadd                   sshd default
#rcadd                   vixie-cron default
#rcadd                   syslog-ng default

# get kernel dotconfig from running kernel
cat /proc/config.gz | gzip -d > /dotconfig