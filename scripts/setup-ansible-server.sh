yum install -y epel-release rsync lvm2 gcc-c++ make cmake net-tools sysstat dstat git epel-release chrony telnet mlocate lsof bind-utils

systemctl disable firewalld
systemctl start ntpd
systemctl enable ntpd

sed -i 's+^SELINUX=.*+SELINUX=disabled+' /etc/selinux/config

yum -y update
mkdir /root/.ssh/
rsync -avz /vagrant/keys/$HOSTNAME/ /root/.ssh/
cp /vagrant/keys/authorized_keys /root/.ssh/authorized_keys
cp /vagrant/keys/known_hosts /root/.ssh/
cp /vagrant/keys/vagrant_user/id_rsa* ~vagrant/.ssh/
chmod 0400 ~vagrant/.ssh/id_rsa
cat ~vagrant/.ssh/id_rsa.pub >> ~vagrant/.ssh/authorized_keys
chown -R root:root /root/.ssh/
chmod 700 /root/.ssh/
chmod 0400 /root/.ssh/id_dsa

cat /vagrant/hosts >> /etc/hosts

yum -y install ansible

reboot
