part sda 1 83 100M  # /boot
part sda 2 82 2048M # swap
part sda 3 83 +     # /

luks bootpw    a    # CHANGE ME
luks /dev/sda2 swap aes sha256
luks /dev/sda3 root aes sha256

format /dev/sda1        ext2
format /dev/mapper/swap swap
format /dev/mapper/root ext4

mountfs /dev/sda1        ext2 /boot
mountfs /dev/mapper/swap swap
mountfs /dev/mapper/root ext4 / noatime

# retrieve latest autobuild stage version for stage_uri
wget ftp://mirrors.kernel.org/gentoo/releases/x86/autobuilds/latest-stage3-i686.txt -O /tmp/stage3.version
latest_stage_version=$(cat /tmp/stage3.version | grep tar.bz2)

stage_uri               ftp://mirrors.kernel.org/gentoo/releases/x86/autobuilds/${latest_stage_version}
tree_type               snapshot ftp://mirrors.kernel.org/gentoo/snapshots/portage-latest.tar.bz2

# get kernel dotconfig from running kernel
cat /proc/config.gz | gzip -d > /dotconfig

kernel_config_file      /dotconfig
rootpw                  a
genkernel_opts          --luks # required
kernel_sources          gentoo-sources
timezone                UTC
bootloader              grub
bootloader_kernel_args  crypt_root=/dev/sda3 # should match root device in the $luks variable
keymap                  us # fr be-latin1
hostname                gentoo-luks
#extra_packages          openssh syslog-ng
#rcadd                   sshd default
#rcadd                   syslog-ng default
#rcadd                   vixie-cron default

# MUST HAVE
post_install_cryptsetup() {
    # this tells where to find the swap to encrypt
    cat >> ${chroot_dir}/etc/conf.d/dmcrypt <<EOF
swap=swap
source='/dev/sda2'
EOF
    # this will activate the encrypted swap on boot
    cat >> ${chroot_dir}/etc/conf.d/local <<EOF
swapon /dev/sda2
EOF
}
