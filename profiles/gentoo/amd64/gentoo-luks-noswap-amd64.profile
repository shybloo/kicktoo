part sda 1 83 100M  # /boot
part sda 2 83 +     # /

luks bootpw    a    # CHANGE ME
luks /dev/sda2 root aes sha256

format /dev/sda1        ext2
format /dev/mapper/root ext4

mountfs /dev/sda1        ext2 /boot
mountfs /dev/mapper/root ext4 / noatime

# retrieve latest autobuild stage version for stage_uri
wget ftp://mirrors.kernel.org/gentoo/releases/amd64/autobuilds/latest-stage3-amd64.txt -O /tmp/stage3.version
latest_stage_version=$(cat /tmp/stage3.version | grep tar.bz2)

stage_uri               ftp://mirrors.kernel.org/gentoo/releases/amd64/autobuilds/${latest_stage_version}
tree_type               snapshot ftp://mirrors.kernel.org/gentoo/snapshots/portage-latest.tar.bz2

# get kernel dotconfig from running kernel
cat /proc/config.gz | gzip -d > /dotconfig

kernel_config_file      /dotconfig
rootpw                  a
genkernel_opts          --luks # required
kernel_sources          gentoo-sources
timezone                UTC
bootloader              grub
bootloader_kernel_args  crypt_root=/dev/sda2 # should match root device in the $luks variable
keymap                  fr # be-latin1 us
hostname                gentoo-luks
#extra_packages         openssh syslog-ng
#rcadd                  sshd default
#rcadd                  syslog-ng default
#rcadd                  vixie-cron default

# get kernel dotconfig from running kernel
cat /proc/config.gz | gzip -d > /dotconfig
