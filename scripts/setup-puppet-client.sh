rpm -Uvh https://yum.puppet.com/puppet6-release-el-7.noarch.rpm
yum clean all
yum repolist
yum install -y puppet-agent rsync lvm2 gcc-c++ make cmake net-tools sysstat dstat git epel-release nedit ntp ntpdate telnet mlocate

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

echo "server = puppet" >> /etc/puppetlabs/puppet/puppet.conf

cp /vagrant/files/puppet-run.* /usr/lib/systemd/system
systemctl start puppet-run.timer

#reboot
/opt/puppetlabs/bin/puppet agent -t
