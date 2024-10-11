#!/bin/bash
#service vsftpd start

# Add the USER, change his password and declare him as the owner of wordpress folder and all subfolders
# Add the user, set the password, and declare as owner of WordPress folder and all subfolders
adduser $FTP_USER << EOF
$FTP_PASS
$FTP_PASS
EOF

# Alternatively, you can set the password like this:
# echo "$FTP_USER:$FTP_PASS" | /usr/sbin/chpasswd &> /dev/null

# Add user to vsftpd userlist
echo "$FTP_USER" | tee -a /etc/vsftpd.userlist &> /dev/null

# Create FTP home directories
mkdir -p /home/$FTP_USER/ftp/files
chown nobody:nogroup /home/$FTP_USER/ftp
chmod a-w /home/$FTP_USER/ftp
chown $FTP_USER:$FTP_USER /home/$FTP_USER/ftp/files

# Ensure the secure_chroot_dir exists
mkdir -p /var/run/vsftpd/empty
chmod 755 /var/run/vsftpd/empty

# Update vsftpd configuration
echo "
listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
allow_writeable_chroot=YES
pasv_enable=YES
pasv_min_port=50000
pasv_max_port=50005
userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=NO
secure_chroot_dir=/var/run/vsftpd/empty
local_root=/home/$FTP_USER/ftp
" >> /etc/vsftpd.conf


vsftpd
