#!/bin/bash

#set the network
route del default
route add default gateway 172.10.0.1

#make NGINX listen on the correct stuff
rm /ip_nginx
echo "listen $NGINXIP:80 default_server;" > /ip_nginx

#describe interface name
rm /iface_control
rm /iface_web
ifaceCtrl=$(netstat -ie | grep -B1 "$NGINXIP" | head -n1 | awk '{print $1}' | sed -e 's/://g')
echo "$ifaceCtrl" > /iface_control
if [ "$ifaceCtrl" == "eth0" ]; then
    echo "eth1" > /iface_web
else
    echo "eth0" > /iface_web
fi

#start stuff
mkdir -p /var/run/sshd

chown -R root:root /root
mkdir -p /root/.config/pcmanfm/LXDE/
cp /usr/share/doro-lxde-wallpapers/desktop-items-0.conf /root/.config/pcmanfm/LXDE/

if [ -n "$VNC_PASSWORD" ]; then
    echo -n "$VNC_PASSWORD" > /.password1
    x11vnc -storepasswd $(cat /.password1) /.password2
    chmod 400 /.password*
    sed -i 's/^command=x11vnc.*/& -rfbauth \/.password2/' /etc/supervisor/conf.d/supervisord.conf
    export VNC_PASSWORD=
fi

cd /usr/lib/web && ./run.py > /var/log/web.log 2>&1 &
nginx -c /etc/nginx/nginx.conf
nohup /bin/tini -- /usr/bin/supervisord -n &

exec "$STARTUPSCRIPT"