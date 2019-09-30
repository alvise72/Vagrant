rpm -Uvh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
yum clean all
yum repolist
yum install -y puppet-server

yum -y install rsync lvm2 gcc-c++ make cmake net-tools sysstat dstat git epel-release
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

cat << EOF > /etc/puppet/puppet.conf
[main]
dns_alt_names=puppet
certname = puppet
    # The Puppet log directory.
    # The default value is '$vardir/log'.
    logdir = /var/log/puppet

    # Where Puppet PID files are kept.
    # The default value is '$vardir/run'.
    rundir = /var/run/puppet

    # Where SSL certificates are kept.
    # The default value is '$confdir/ssl'.
    ssldir = $vardir/ssl

[agent]
    # The file in which puppetd stores a list of the classes
    # associated with the retrieved configuratiion.  Can be loaded in
    # the separate ``puppet`` executable using the ``--loadclasses``
    # option.
    # The default value is '$confdir/classes.txt'.
    classfile = $vardir/classes.txt

    # Where puppetd caches the local configuration.  An
    # extension indicating the cache format is added automatically.
    # The default value is '$confdir/localconfig'.
    localconfig = $vardir/localconfig
EOF

sudo -u puppet puppet master --no-daemonize --verbose &
systemctl enable puppetmaster
#/vagrant/SSI/Spectrum_Scale_Erasure_Code-5.0.3.2-x86_64-Linux-install --silent --text-only
sleep 20
reboot