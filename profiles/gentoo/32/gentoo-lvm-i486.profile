part sda 1 83 100M
part sda 2 82 2G
part sda 3 83 8G
part sda 4 8e +      # linux lvm type

lvm_volgroup vg /dev/sda4

lvm_logvol vg 10G   usr
lvm_logvol vg 5G    home
lvm_logvol vg 5G    opt
lvm_logvol vg 10G   var
lvm_logvol vg 2G    tmp

format /dev/sda1    ext2
format /dev/sda2    swap
format /dev/sda3    ext4
format /dev/vg/usr  ext4
format /dev/vg/home ext4
format /dev/vg/opt  ext4
format /dev/vg/var  ext4
format /dev/vg/tmp  ext4

mountfs /dev/sda1    ext2 /boot
mountfs /dev/sda2    swap
mountfs /dev/sda3    ext4 /     noatime
mountfs /dev/vg/usr  ext4 /usr  noatime
mountfs /dev/vg/home ext4 /home noatime
mountfs /dev/vg/opt  ext4 /opt  noatime
mountfs /dev/vg/var  ext4 /var  noatime
mountfs /dev/vg/tmp  ext4 /tmp  noatime

stage_uri           ftp://mirrors.kernel.org/gentoo/releases/x86/autobuilds/20110705/stage3-i486-20110705.tar.bz2
tree_type           snapshot ftp://mirrors.kernel.org/gentoo/snapshots/portage-latest.tar.xz
kernel_config_file  /dotconfig
genkernel_opts      --lvm # required
kernel_sources      gentoo-sources
timezone            UTC
rootpw              a
bootloader          grub
keymap              fr # be-latin1 en
hostname            gentoo-lvm
extra_packages      lvm2 dhcpcd # vim openssh vixie-cron syslog-ng
#rcadd               sshd       default
#rcadd               vixie-cron default
#rcadd               syslog-ng  default

# get kernel dotconfig from running kernel
cat /proc/config.gz | gzip -d > /dotconfig
