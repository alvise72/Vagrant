mkdir -p /root/.ssh
rsync -avz /vagrant/keys/ /root/.ssh/
chmod 0400 /root/.ssh/id_rsa
chmod 0644 /root/.ssh/id_rsa.pub
chmod 0600 /root/.ssh/authorized_keys
chown -R root:root /root/.ssh
chmod 0700 /root/.ssh

cat /vagrant/hosts >> /etc/hosts
sudo mkdir -p /etc/ssh/ssh_config.d/
cp /vagrant/files/control/etc/ssh/ssh_config.d/nohostcheck.conf /etc/ssh/ssh_config.d/nohostcheck.conf
systemctl restart sshd

cp /vagrant/keys/id_rsa ~vagrant/.ssh/
cp /vagrant/keys/id_rsa.pub ~vagrant/.ssh/
cat /vagrant/keys/authorized_keys >> ~vagrant/.ssh/authorized_keys
chown vagrant:vagrant ~vagrant/.ssh/*
