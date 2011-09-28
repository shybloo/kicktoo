part sda 1 82 2048M
part sda 2 83 +

format /dev/sda1 swap
format /dev/sda2 ext4

mountfs /dev/sda1 swap
mountfs /dev/sda2 ext4 / noatime

# retrieve latest autobuild stage version for stage_uri
wget http://distfiles.gentoo.org/releases/x86/autobuilds/latest-stage3-i486.txt -O /tmp/stage3.version
latest_stage_version=$(cat /tmp/stage3.version | grep tar.bz2)

stage_uri               http://distfiles.gentoo.org/releases/x86/autobuilds/${latest_stage_version}
tree_type    snapshot   http://distfiles.gentoo.org/releases/snapshots/portage-latest.tar.xz

# get kernel dotconfig from running kernel
cat /proc/config.gz | gzip -d > /dotconfig

kernel_config_file      /dotconfig
kernel_sources          gentoo-sources
timezone                UTC
rootpw                  a
bootloader              grub
keymap                  us # be-latin1 fr
hostname                gentoo
extra_packages          dhcpcd syslog-ng vim # openssh
#rcadd                   sshd       default
#rcadd                   syslog-ng  default
