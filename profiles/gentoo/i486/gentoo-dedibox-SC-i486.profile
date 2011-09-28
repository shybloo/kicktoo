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
wget -q http://distfiles.gentoo.org/releases/x86/autobuilds/latest-stage3-i486.txt -O /tmp/stage3.version
latest_stage_version=$(cat /tmp/stage3.version | grep tar.bz2)

stage_uri               http://distfiles.gentoo.org/releases/x86/autobuilds/${latest_stage_version}
tree_type     snapshot  http://distfiles.gentoo.org/releases/snapshots/current/portage-latest.tar.bz2
#tree_type               sync

# compile kernel from sources using the right .config
kernel_config_file      $(pwd)/kconfig/dedibox-SC-x86-kernel.config
kernel_sources          gentoo-sources
genkernel_opts          --loglevel=5

timezone                UTC
rootpw                  a
bootloader              grub
keymap                  fr
hostname                gentoo
extra_packages          openssh # dhcpcd syslog-ng vim

rcadd                   network     default
rcadd                   sshd       default
#rcadd                   syslog-ng  default

# MUST HAVE
post_install_extra_packages() {
    cat >> ${chroot_dir}/etc/conf.d/network <<EOF
ifconfig_eth0="88.191.122.122 netmask 255.255.255.0 brd 88.191.122.255"
defaultroute="gw 88.191.122.1"
EOF
}
