part sda 1 83 100M
part sda 2 82 4096M
part sda 3 83 +

format /dev/sda1 ext2
format /dev/sda2 swap
format /dev/sda3 ext4

mountfs /dev/sda1 ext2 /boot
mountfs /dev/sda2 swap
mountfs /dev/sda3 ext4 / noatime

stage_uri               http://ftp.osuosl.org/pub/funtoo/funtoo-stable/x86-32bit/i686/stage3-current.tar.xz
tree_type     snapshot  http://ftp.osuosl.org/pub/funtoo/funtoo-stable/snapshots/portage-current.tar.xz

# ship the binary kernel instead of compiling (faster)
kernel_binary           $(pwd)/kbin/kernel-genkernel-x86-2.6.39-gentoo-r3
initramfs_binary        $(pwd)/kbin/initramfs-genkernel-x86-2.6.39-gentoo-r3
systemmap_binary        $(pwd)/kbin/System.map-genkernel-x86-2.6.39-gentoo-r3

timezone                UTC
rootpw                  a
bootloader              grub
keymap                  fr
hostname                funtoo
extra_packages          openssh # dhcpcd syslog-ng vim

rcadd                   network     default
rcadd                   sshd       default
#rcadd                   syslog-ng  default

#############################################################################
# 1. commented skip runsteps are actually running!                          #
# 2. put your custom code if any in pre_ or post_ functions                 #
#############################################################################

# pre_partition() {
# }
# skip partition
# post_partition() {
# }

# pre_setup_mdraid() {
# }
# skip setup_mdraid
# post_setup_mdraid() {
# }

# pre_setup_lvm() {
# }
# skip setup_lvm
# post_setup_lvm() {
# }

# pre_luks_devices() {
# }
# skip luks_devices
# post_luks_devices() {
# }

# pre_format_devices() {
# }
# skip format_devices
# post_format_devices() {
# }

# pre_mount_local_partitions() {
# }
# skip mount_local_partitions
# post_mount_local_partitions() {
# }

# pre_mount_network_shares() {
# }
# skip mount_network_shares
# post_mount_network_shares() {
# }

# pre_fetch_stage_tarball() {
# }
# skip fetch_stage_tarball
# post_fetch_stage_tarball() {
# }

# pre_unpack_stage_tarball() {
# }
# skip unpack_stage_tarball
# post_unpack_stage_tarball() {
# }

# pre_prepare_chroot() {
# }
# skip prepare_chroot
# post_prepare_chroot() { 
# }

# pre_setup_fstab() {
# }
# skip setup_fstab
# post_setup_fstab() { 
# }

# pre_fetch_repo_tree() {
# }
# skip fetch_repo_tree
# post_fetch_repo_tree() {
# }

# pre_unpack_repo_tree() {
# }
# skip unpack_repo_tree
post_unpack_repo_tree() {
    # git style Funtoo portage
    spawn_chroot "cd /usr/portage && git checkout funtoo.org" || die "could not checkout funtoo git repo"
}

# pre_install_cryptsetup() {
# }
# skip install_cryptsetup
# post_install_cryptsetup() {
# }

# pre_copy_kernel() {
# }
# skip copy_kernel
# post_copy_kernel() {
# }

# pre_build_kernel() {
# }
# skip build_kernel
# post_build_kernel() {
# }

# pre_setup_network_post() {
# }
# skip setup_network_post
# post_setup_network_post() {
# }

# pre_setup_root_password() {
# }
# skip setup_root_password
# post_setup_root_password() {
# }

# pre_setup_timezone() {
# }
# skip setup_timezone
# post_setup_timezone() {
# }

# pre_setup_keymap() {
# }
# skip setup_keymap
# post_setup_keymap() {
# }

# pre_setup_host() {
# }
# skip setup_host
# post_setup_host() {
# }

# pre_install_bootloader() {
# }
# skip install_bootloader
post_install_bootloader() {
    # $(echo ${device} | cut -c1-8) is like /dev/sdx
    spawn_chroot "grub-install $(echo ${device} | cut -c1-8)" || die "cannot grub-install $(echo ${device} | cut -c1-8)"
    spawn_chroot "boot-update"                                || die "boot-update failed"
}

# pre_configure_bootloader() {
# }
skip configure_bootloader
# post_configure_bootloader() {
# }

# pre_install_extra_packages() {
# }
# skip install_extra_packages
post_install_extra_packages() {
    cat >> ${chroot_dir}/etc/conf.d/network <<EOF
ifconfig_eth0="88.xxx.xxx.xxx netmask 255.255.255.0 brd 88.xxx.xxx.255"
defaultroute="gw 88.xxx.xxx.1"
EOF
}

# pre_add_and_remove_services() {
# }
# skip add_and_remove_services
# post_add_and_remove_services() {
# }

# pre_run_post_install_script() { 
# }
# skip run_post_install_script
# post_run_post_install_script() {
# }
