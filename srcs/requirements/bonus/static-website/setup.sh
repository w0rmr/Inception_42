#! /bin/bash
if [ -d "/home/$SSH_USER"]; then
    echo "USER exist" 
else  
    adduser $SSH_USER << EOF
    $SSH_PASS
    $SSH_PASS
EOF
    mkdir -p /home/$SSH_USER/files
    mv files/* /home/$SSH_USER/files/
    chown -R $SSH_USER:$SSH_USER /home/$SSH_USER/files
    chmod 755 /home/$SSH_USER/files
    chmod -R 644 /home/$SSH_USER/files/*

    echo "Port  $SSH_PORT" >> /etc/ssh/sshd_config
    echo "Port  $SSH_PORT" >> /etc/ssh/ssh_config
    service  ssh restart
fi
exec $@
