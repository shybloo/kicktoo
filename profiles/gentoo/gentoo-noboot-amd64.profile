part sda 1 82 2048M
part sda 2 83 +

format /dev/sda1 swap
format /dev/sda2 ext4

mountfs /dev/sda1 swap
mountfs /dev/sda2 ext4 / noatime

stage_uri               ftp://mirrors.kernel.org/gentoo/releases/amd64/autobuilds/20110708/stage3-amd64-20110708.tar.bz2
tree_type               snapshot ftp://mirrors.kernel.org/gentoo/snapshots/portage-latest.tar.xz
kernel_config_file      /dotconfig
kernel_sources	        gentoo-sources
timezone                UTC
rootpw                  a
bootloader              grub
keymap	                be-latin1 # fr en
hostname                gentoo
extra_packages          dhcpcd syslog-ng vim # openssh
#rcadd                   sshd       default
#rcadd                   syslog-ng  default

# get kernel dotconfig from running kernel
cat /proc/config.gz | gzip -d > /dotconfig
