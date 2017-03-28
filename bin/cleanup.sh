#!/bin/sh

# Credits to:
#  - http://vstone.eu/reducing-vagrant-box-size/
#  - https://github.com/mitchellh/vagrant/issues/343

unset HISTFILE
rm -f /root/.bash_history
rm -f ~/.bash_history
rm -f ~/gdb*.txt
rm -f ~/*.log
#rm -rf ~/.local/share/composer
#rm -rf ~/.cache/composer
rm -rf ~/.cache/ctrlp
rm -rf ~/.cscope.vim
rm -rf ~/.neocomplcache
#rm -rf ~/.npm
#rm -rf ~/.node-gyp
rm -rf ~/git
rm -rf ~/tmp
rm -rf ~/temp

aptitude -y purge ri
aptitude -y purge installation-report landscape-common wireless-tools wpasupplicant ubuntu-serverguide
aptitude -y purge python-dbus libnl1 python-smartpm python-twisted-core libiw30
aptitude -y purge python-twisted-bin libdbus-glib-1-2 python-pexpect python-pycurl python-serial python-gobject python-pam python-openssl libffi5
apt-get purge -y linux-image-3.0.0-12-generic-pae

# Remove APT cache
apt-get clean -y
apt-get autoclean -y

# Zero free space to aid VM compression
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Cleanup log files
find /var/log -type f | while read f; do echo -ne '' > $f; done;

# Whiteout root
count=`df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}'`;
let count--
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count;
rm /tmp/whitespace;

# Whiteout /boot
count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`;
let count--
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count;
rm /boot/whitespace;

swappart=$(cat /proc/swaps | grep -v Filename | tail -n1 | awk -F ' ' '{print $1}')

if [ "$swappart" != "" ]; then
  swapoff $swappart;
  dd if=/dev/zero of=$swappart;
  mkswap $swappart;
  swapon $swappart;
fi

