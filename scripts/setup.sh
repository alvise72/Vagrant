ROOT_HOME="/root"
ROOT_SSH_HOME="$ROOT_HOME/.ssh"
ROOT_AUTHORIZED_KEYS="$ROOT_SSH_HOME/authorized_keys"
VAGRANT_HOME="/home/vagrant"
VAGRANT_SSH_HOME="$VAGRANT_HOME/.ssh"
VAGRANT_AUTHORIZED_KEYS="$VAGRANT_SSH_HOME/authorized_keys"

# Setup keys for root user.
ssh-keygen -C root@localhost -f "$ROOT_SSH_HOME/id_rsa" -q -N ""
cat "$ROOT_SSH_HOME/id_rsa.pub" >> "$ROOT_AUTHORIZED_KEYS"
chmod 644 "$ROOT_AUTHORIZED_KEYS"

# Setup keys for vagrant user.
ssh-keygen -C vagrant@localhost -f "$VAGRANT_SSH_HOME/id_rsa" -q -N ""
cat "$VAGRANT_SSH_HOME/id_rsa.pub" >> "$ROOT_AUTHORIZED_KEYS"
cat "$VAGRANT_SSH_HOME/id_rsa.pub" >> "$VAGRANT_AUTHORIZED_KEYS"
chmod 644 "$VAGRANT_AUTHORIZED_KEYS"
chown -R vagrant:vagrant "$VAGRANT_SSH_HOME"

yum -y install lvm2 gcc-c++ make cmake net-tools sysstat dstat
yum -y update

(
echo n # Add a new partition
echo p # Primary partition
echo 1 # Partition number
echo   # First sector (Accept default: 1)
echo   # Last sector (Accept default: varies)
echo t
echo 8e
echo wq # Write changes
) | sudo fdisk /dev/sdb

(
echo n # Add a new partition
echo p # Primary partition
echo 1 # Partition number
echo   # First sector (Accept default: 1)
echo   # Last sector (Accept default: varies)
echo t
echo 8e
echo wq # Write changes
) | sudo fdisk /dev/sdc

pvcreate /dev/sdb1
pvcreate /dev/sdc1
vgcreate raid1vg /dev/sdb1
vgextend raid1vg /dev/sdc1
sz=$(vgdisplay |grep "VG Size"|awk '{print $(NF-1)""$NF}')
lvcreate --type raid1 -l 100%FREE -n raid1 raid1vg
mkfs.ext4 /dev/raid1vg/raid1
mount /dev/raid1vg/raid1 /mnt
