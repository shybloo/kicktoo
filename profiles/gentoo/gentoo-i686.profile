part sda 1 83 100M
part sda 2 82 2048M
part sda 3 83 +

format /dev/sda1 ext2
format /dev/sda2 swap
format /dev/sda3 ext4

mountfs /dev/sda1 ext2 /boot
mountfs /dev/sda2 swap
mountfs /dev/sda3 ext4 / noatime

# retrieve latest autobuild stage version for stage_uri
wget ftp://mirrors.kernel.org/gentoo/releases/x86/autobuilds/latest-stage3-i686.txt -O /tmp/stage3.version
latest_stage_version=$(cat /tmp/stage3.version | grep tar.bz2)

stage_uri               ftp://mirrors.kernel.org/gentoo/releases/x86/autobuilds/${latest_stage_version}
tree_type               snapshot ftp://mirrors.kernel.org/gentoo/snapshots/portage-latest.tar.xz

# get kernel dotconfig from running kernel
cat /proc/config.gz | gzip -d > /dotconfig

kernel_config_file      /dotconfig
kernel_sources	        gentoo-sources
timezone                UTC
rootpw                  a
bootloader              grub
keymap	                us # be-latin1 fr
hostname                gentoo
extra_packages          dhcpcd syslog-ng vim # openssh
#rcadd                   sshd       default
#rcadd                   syslog-ng  default
