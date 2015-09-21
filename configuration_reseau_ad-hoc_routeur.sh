#/usr/bin/env sh

WIFI_CARD="wlp2s0"
ETH_CARD="enp1s0"
ETH_CARD_IP="192.168.2.1"
AD_HOC_CARD="wlp0s29f7u4"
AD_HOC_CARD_IP="192.168.2.1"
AD_HOC_ESSID="SkippyRouteur"
DHCP_CONF="/home/skippy/dhcpd.conf"
#echo $AD_HOC_CARD
#echo $WIFI_CAR
#echo $ETH_CARD

# Donner une ip fixe à la carte ethernet
ifconfig $ETH_CARD $ETH_CARD_IP

# Desactive la carte ad_hoc
#ifconfig $AD_HOC_CARD down

#Mettre la seconde carte wifi en mode ad-hoc
#iwconfig $AD_HOC_CARD mode "Ad-hoc"

# Nommer le reseau ad-hoc
#iwconfig $AD_HOC_CARD essid $AD_HOC_ESSID

# Donner une IP à la carte wifi
#ifconfig $AD_HOC_CARD $AD_HOC_CARD_IP

# Activer la carte
#ifconfig $AD_HOC_CARD up

# Activer l'ip-fowarding
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o $WIFI_CARD -j MASQUERADE
iptables -t nat -A POSTROUTING -o $ETH_CARD -j MASQUERADE
#iptables -t nat -A POSTROUTING -o $AD_HOC_CARD -j MASQUERADE

# on lance le serveur dhcp
#dhcpd -f -4 -cf $DHCP_CONF $AD_HOC_CARD
