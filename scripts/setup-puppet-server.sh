rpm -Uvh https://yum.puppet.com/puppet6-release-el-7.noarch.rpm
yum clean all
yum repolist
yum install -y puppetserver rsync lvm2 gcc-c++ make cmake net-tools sysstat dstat git epel-release nedit ntp ntpdate telnet mlocate lsof bind-utils

systemctl disable firewalld
ntpdate 0.centos.pool.ntp.org
systemctl start ntpd
systemctl enable ntpd

sed -i 's+^SELINUX=.*+SELINUX=disabled+' /etc/selinux/config

yum -y update
mkdir /root/.ssh/
rsync -avz /vagrant/keys/$HOSTNAME/ /root/.ssh/
cp /vagrant/keys/authorized_keys /root/.ssh/authorized_keys
cp /vagrant/keys/known_hosts /root/.ssh/
chown -R root:root /root/.ssh/
chmod 700 /root/.ssh/
chmod 0400 /root/.ssh/id_dsa

cat /vagrant/hosts >> /etc/hosts
echo 'source /etc/profile.d/puppet-agent.sh' >> /home/vagrant/.bashrc
echo "sudo su -" >> /home/vagrant/.bashrc

sed -i 's+JAVA_ARGS=\"-Xms2g -Xmx2g+JAVA_ARGS=\"-Xms512m -Xmx512m+' /etc/sysconfig/puppetserver

echo "autosign = true" >> /etc/puppetlabs/puppet/puppet.conf

/opt/puppetlabs/bin/puppetserver ca setup

cp -r /vagrant/files/puppet/code/* /etc/puppetlabs/code/

systemctl start puppetserver
systemctl enable puppetserver

/opt/puppetlabs/bin/puppet module install puppetlabs-inifile
/opt/puppetlabs/bin/puppet module install puppetlabs-lvm
reboot
