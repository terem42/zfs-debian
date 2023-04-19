# This scripts aims to test the ZFS upgrade from bullseye -> bookworm
# run the script within sbuild-shell environment, e.g.
#
#   $ sudo sbuild-shell chroot:bullseye-amd64-sbuild
#
# Note, remember to set union-type to "none" for the specified schroot env,
# or usrmerge will cause lots of trouble.

# install zfs from stable
echo "deb http://deb.debian.org/debian bullseye main contrib non-free" > /etc/apt/sources.list
apt update -y
apt upgrade -y
apt install eatmydata -y
eatmydata -- apt install vim fish -y
eatmydata -- apt install linux-image-amd64 linux-headers-amd64 linux-libc-dev dkms -y
eatmydata -- apt install zfsutils-linux -y
find /usr/lib/modules | grep zfs

# upgrade to unstable (bookworm)
echo "deb http://deb.debian.org/debian unstable main contrib non-free" > /etc/apt/sources.list
eatmydata -- apt update -y
eatmydata -- apt dist-upgrade -y
eatmydata -- apt autoremove -y
find /usr/lib/modules | grep zfs
