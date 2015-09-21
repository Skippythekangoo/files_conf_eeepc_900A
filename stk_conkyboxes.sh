#!/bin/bash
killall conky
sleep 2s
## here starts conky-boxes
conky -c ~/scripts/conkyrc_time &
conky -c ~/scripts/conkyrc_system &
conky -c ~/scripts/conkyrc_ibm &
conky -c ~/scripts/conkyrc_proc &
conky -c ~/scripts/conkyrc_mem &
conky -c ~/scripts/conkyrc_disks &
conky -c ~/scripts/conkyrc_cal &
conky -c ~/scripts/conkyrc_cpu &
conky -c ~/scripts/conkyrc_net &
## here starts conky-title
conky -c ~/scripts/conkyrc_t_net &
conky -c ~/scripts/conkyrc_t_proc &
conky -c ~/scripts/conkyrc_t_mem &
conky -c ~/scripts/conkyrc_t_ibm &
conky -c ~/scripts/conkyrc_t_cal &
conky -c ~/scripts/conkyrc_t_system &
conky -c ~/scripts/conkyrc_t_cpu &
conky -c ~/scripts/conkyrc_t_disks &
conky -c ~/scripts/conkyrc_t_time &
exit 0
