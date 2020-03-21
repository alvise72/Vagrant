mkdir -p /root/.ssh/
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
