yum install -y epel-release
yum -y install rsync lvm2 gcc-c++ make cmake net-tools sysstat dstat git epel-release chrony telnet mlocate lsof bind-utils vim python2 ansible strace tree rhel-system-roles

systemctl disable firewalld
systemctl start chronyd
systemctl enable chronyd

sed -i 's+^SELINUX=.*+SELINUX=disabled+' /etc/selinux/config

yum -y update

sudo mkdir -p /root/.ssh/
sudo rsync -avz /vagrant/keys/ /root/.ssh/
sudo chmod 0400 /root/.ssh/id_rsa
sudo chmod 0644 /root/.ssh/id_rsa.pub
sudo chmod 0600 /root/.ssh/authorized_keys
sudo chown -R root:root /root/.ssh
sudo chmod 700 /root/.ssh

sudo cat /vagrant/hosts >> /etc/hosts
sudo mkdir -p /etc/ssh/ssh_config.d/
sudo cp /vagrant/files/control/etc/ssh/ssh_config.d/nohostcheck.conf /etc/ssh/ssh_config.d/nohostcheck.conf
systemctl restart sshd

cp /vagrant/keys/id_rsa ~vagrant/.ssh/
cp /vagrant/keys/id_rsa.pub ~vagrant/.ssh/
cat /vagrant/keys/authorized_keys >> ~vagrant/.ssh/authorized_keys
chown vagrant:vagrant ~vagrant/.ssh/*

