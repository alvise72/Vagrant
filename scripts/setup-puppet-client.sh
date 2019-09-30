rpm -Uvh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
yum clean all
yum repolist
yum install -y puppet
yum -y install rsync lvm2 gcc-c++ make cmake net-tools sysstat dstat git
yum -y update
mkdir /root/.ssh/
rsync -avz /vagrant/keys/$HOSTNAME/ /root/.ssh/
cp /vagrant/keys/authorized_keys /root/.ssh/authorized_keys
cp /vagrant/keys/known_hosts /root/.ssh/
chown -R root:root /root/.ssh/
chmod 700 /root/.ssh/
chmod 0400 /root/.ssh/id_dsa

cat /vagrant/hosts >> /etc/hosts
echo "sudo su -" >> /home/vagrant/.bashrc
echo 'export PATH=${PATH}:/opt/puppetlabs/bin' >> /home/vagrant/.bashrc
echo "server=linux1" >> /etc/puppet/puppet.conf

#/vagrant/SSI/Spectrum_Scale_Erasure_Code-5.0.3.2-x86_64-Linux-install --silent --text-only

reboot