yum install -y epel-release
yum clean all
yum -y install rsync lvm2 gcc-c++ make cmake net-tools sysstat dstat git epel-release chrony telnet mlocate lsof bind-utils vim python2 ansible strace tree rhel-system-roles

systemctl disable firewalld
systemctl start chronyd
systemctl enable chronyd

sed -i 's+^SELINUX=.*+SELINUX=disabled+' /etc/selinux/config

yum -y update
mkdir -p /root/.ssh/
rsync -avz /vagrant/keys/root_user/ /root/.ssh/
chmod 0400 /root/.ssh/id_dsa
chmod 0600 /root/.ssh/authorized_keys
#cat ~vagrant/.ssh/id_rsa.pub >> ~vagrant/.ssh/authorized_keys
#touch ~vagrant/.ssh/config
#echo "StrictHostKeyChecking no" >>  ~vagrant/.ssh/config
#chown -R root:root /root/.ssh/
chmod 700 /root/.ssh/
#chmod 0400 /root/.ssh/id_dsa

#chown -R vagrant:vagrant /home/vagrant

cat /vagrant/hosts >> /etc/hosts

cp /vagrant/files/control/etc/ssh/ssh_config.d/nohostcheck.conf /etc/ssh/ssh_config.d/nohostcheck.conf

#cp -r /vagrant/files/control/ansible ~vagrant
#chown -R vagrant ~vagrant/*

#yum install -y https://rpmfind.net/linux/epel/7/x86_64/Packages/s/sshuttle-0-8.20120810git9ce2fa0.el7.noarch.rpm
#ln -s /usr/bin/python2 /usr/bin/python
#pip-3.6 install python-hpilo python-ilorest-library
