#! /bin/bash
adduser $SSH_USER << EOF
$SSH_PASS
$SSH_PASS
EOF
mkdir -p /home/$SSH_USER/files
mv files/* /home/$SSH_USER/files/
chown $SSH_USER:$SSH_USER /home/$SSH_USER/files
cd /home/$SSH_USER/files
chmod 700 /home/$SSH_USER/files

echo "Port  $SSH_PORT" >> /etc/ssh/sshd_config
echo "Port  $SSH_PORT" >> /etc/ssh/ssh_config
service  ssh restart
exec $@
