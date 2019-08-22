yum -y install rsync lvm2 gcc-c++ make cmake net-tools sysstat dstat git
yum -y update
mkdir /root/.ssh/
rsync -avz /vagrant/keys/$HOSTNAME/ /root/.ssh/
cp /vagrant/keys/authorized_keys /root/.ssh/authorized_keys
cp /vagrant/keys/known_hosts /root/.ssh/
chown -R root:root /root/.ssh/
chmod 700 /root/.ssh/
chmod 0400 /root/.ssh/id_dsa

/vagrant/SSI/Spectrum_Scale_Erasure_Code-5.0.3.2-x86_64-Linux-install --silent --text-only

reboot
#(
#echo n # Add a new partition
#echo p # Primary partition
#echo 1 # Partition number
#echo   # First sector (Accept default: 1)
#echo   # Last sector (Accept default: varies)
#echo t
#echo 8e
#echo wq # Write changes
#) | sudo fdisk /dev/sdb

#(
#echo n # Add a new partition
#echo p # Primary partition
#echo 1 # Partition number
#echo   # First sector (Accept default: 1)
#echo   # Last sector (Accept default: varies)
#echo t
#echo 8e
#echo wq # Write changes
#) | sudo fdisk /dev/sdc

#pvcreate /dev/sdb1
#pvcreate /dev/sdc1
#vgcreate raid1vg /dev/sdb1
#vgextend raid1vg /dev/sdc1
#sz=$(vgdisplay |grep "VG Size"|awk '{print $(NF-1)""$NF}')
#lvcreate --type raid1 -l 100%FREE -n raid1 raid1vg
#mkfs.ext4 /dev/raid1vg/raid1
#mount /dev/raid1vg/raid1 /mnt
