#!/bin/vbash
: '
DESCRIPTION

USG loses internet connection time to time.
solution: Renew DHCP lease:
renew dhcp interface eth0


Info & steps to access the scripts
1. Enable SSH on controller
2. Enable port forward from wan to controllers ssh port
3. Enable internet in firewall rule from hml to parola
4. Enable device SSH from remote controller settings -> system -> Network device ssh authentication
5. SSH in to controller
6. SSH in to device using creds from step 4

Dont forget to disable steps 1-4 after you are done.


File locations:

Cron:
/etc/cron.d/
FileName : check-dhcplease
This file is a copy from existing file and modified to be run a script every 5mins

Script & log:
/config/user-data/scripts/check-dhcplease.sh
/config/user-data/scripts/dhcp-logit.txt

'

echo "starting Ping test"

if /bin/ping -c 1 EXTERNAL-IP-HERE | grep "100% packet loss";
then
echo '*************************************' >> /config/user-data/scripts/dhcp-logit.txt;
echo 'No internet connection' >> /config/user-data/scripts/dhcp-logit.txt;
echo 'Date:' $(date) >> /config/user-data/scripts/dhcp-logit.txt;
echo '*************************************' >> /config/user-data/scripts/dhcp-logit.txt;
echo 'DHCP lease information before refresh' >> /config/user-data/scripts/dhcp-logit.txt;
vbash -ic 'show dhcp client leases interface eth0' >> /config/user-data/scripts/dhcp-logit.txt;
echo 'Renewing DHCP Lease' >> /config/user-data/scripts/dhcp-logit.txt;
vbash -ic 'renew dhcp interface eth0' >> /config/user-data/scripts/dhcp-logit.txt;
/bin/sleep 10
echo 'DHCP lease information after refresh' >> /config/user-data/scripts/dhcp-logit.txt;
vbash -ic 'show dhcp client leases interface eth0' >> /config/user-data/scripts/dhcp-logit.txt;
echo '*************************************' >> /config/user-data/scripts/dhcp-logit.txt;
else
echo 'Date:' $(date) 'The internet is up';
fi