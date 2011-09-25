part sda 1 83 100M
part sda 2 82 4096M
part sda 3 83 +

format /dev/sda1 ext2
format /dev/sda2 swap
format /dev/sda3 ext4

mountfs /dev/sda1 ext2 /boot
mountfs /dev/sda2 swap
mountfs /dev/sda3 ext4 / noatime

# retrieve latest autobuild stage version for stage_uri
wget http://distfiles.gentoo.org/releases/x86/autobuilds/latest-stage3-i686.txt -O /tmp/stage3.version
latest_stage_version=$(cat /tmp/stage3.version | grep tar.bz2)

stage_uri               http://distfiles.gentoo.org/releases/x86/autobuilds/${latest_stage_version}
tree_type               sync

# get kernel dotconfig from running kernel
#cat /proc/config.gz | gzip -d > /dotconfig

#kernel_config_file      $(pwd)/kconfig/dedibox-SC-kernel.config
#kernel_sources          gentoo-sources
#genkernel_opts          --loglevel=5
kernel_binary           $(pwd)/kbin/kernel-genkernel-x86-2.6.39-gentoo-r3
initramfs_binary        $(pwd)/kbin/initramfs-genkernel-x86-2.6.39-gentoo-r3
systemmap_binary        $(pwd)/kbin/System.map-genkernel-x86-2.6.39-gentoo-r3

timezone                UTC
rootpw                  a
bootloader              grub
keymap                  fr
hostname                gentoo
extra_packages          dhcpcd syslog-ng vim # openssh
#rcadd                   sshd       default
#rcadd                   syslog-ng  default
