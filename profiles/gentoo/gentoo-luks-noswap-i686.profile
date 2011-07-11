part sda 1 83 100M  # /boot
part sda 2 83 +     # /

luks bootpw    a    # CHANGE ME
luks /dev/sda2 root aes sha256

format /dev/sda1        ext2
format /dev/mapper/root ext4

mountfs /dev/sda1        ext2 /boot
mountfs /dev/mapper/root ext4 / noatime

stage_uri               ftp://mirrors.kernel.org/gentoo/releases/x86/autobuilds/20110705/stage3-i686-20110705.tar.bz2
tree_type               snapshot ftp://mirrors.kernel.org/gentoo/snapshots/portage-latest.tar.xz
kernel_config_file      /dotconfig
rootpw                  a
genkernel_opts          --luks # required
kernel_sources          gentoo-sources
timezone                UTC
bootloader              grub
bootloader_kernel_args  crypt_root=/dev/sda2 # should match root device in the $luks variable
keymap                  fr # be-latin1 en
hostname                gentoo-luks
#extra_packages         openssh syslog-ng
#rcadd                  sshd default
#rcadd                  syslog-ng default
#rcadd                  vixie-cron default

# get kernel dotconfig from running kernel
cat /proc/config.gz | gzip -d > /dotconfig
