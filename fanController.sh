#!/bin/bash

#Fan Control for Dell Server

ipmitool -I lanplus -H YOUR_IP -U login/pw -P login/pw raw 0x30 0x30 0x01 0x00 #enable fan speed override

realtempCore1=$(sudo sysctl -a | grep dev.cpu.0.temperature | cut -c24-25)
realtempCore2=$(sudo sysctl -a | grep dev.cpu.1.temperature | cut -c24-25)
realtempCore3=$(sudo sysctl -a | grep dev.cpu.2.temperature | cut -c24-25)
realtempCore4=$(sudo sysctl -a | grep dev.cpu.3.temperature | cut -c24-25)
realtempCore5=$(sudo sysctl -a | grep dev.cpu.4.temperature | cut -c24-25)
realtempCore6=$(sudo sysctl -a | grep dev.cpu.5.temperature | cut -c24-25)
realtempCore7=$(sudo sysctl -a | grep dev.cpu.6.temperature | cut -c24-25)
realtempCore8=$(sudo sysctl -a | grep dev.cpu.7.temperature | cut -c24-25)
realtempCore9=$(sudo sysctl -a | grep dev.cpu.8.temperature | cut -c24-25)
realtempCore10=$(sudo sysctl -a | grep dev.cpu.9.temperature | cut -c24-25)
realtempCore11=$(sudo sysctl -a | grep dev.cpu.10.temperature | cut -c25-26)
realtempCore12=$(sudo sysctl -a | grep dev.cpu.11.temperature | cut -c25-26)
realtempCore13=$(sudo sysctl -a | grep dev.cpu.12.temperature | cut -c25-26)
realtempCore14=$(sudo sysctl -a | grep dev.cpu.13.temperature | cut -c25-26)
realtempCore15=$(sudo sysctl -a | grep dev.cpu.14.temperature | cut -c25-26)
realtempCore16=$(sudo sysctl -a | grep dev.cpu.15.temperature | cut -c25-26)
alltemps=($realtempCore1 $realtempCore2 $realtempCore3 $realtempCore4 $realtempCore5 $realtempCore6 $realtempCore7 $realtempCore8 $realtempCore9 $realtempCore10 $realtempCore11 $realtempCore12 $realtempCore13 $realtempCore14 $realtempCore15 $realtempCore16)
average=0
for ntimes in {0..15}
do
    average=$((${alltemps[$ntimes]} + $average)) #Create sum of all
done
average=$(($average / 16)) #create avarage
#average=100 #manualOverride
if (($average>=15 && $average<=45)) #set accordingly
then
    ipmitool -I lanplus -H YOUR_IP -U login/pw -P login/pw raw 0x30 0x30 0x02 0xff 0x01 #last hex is fan speed 0x00->min - 0x64->max
elif (($average>=46 && $average<=55))
then
    ipmitool -I lanplus -H YOUR_IP -U login/pw -P login/pw raw 0x30 0x30 0x02 0xff 0x06
elif (($average>=56 && $average<=68))
then
    ipmitool -I lanplus -H YOUR_IP -U login/pw -P login/pw raw 0x30 0x30 0x02 0xff 0x25
elif (($average>=69 && $average<=75))
then
    ipmitool -I lanplus -H YOUR_IP -U login/pw -P login/pw raw 0x30 0x30 0x02 0xff 0x45
else
    ipmitool -I lanplus -H YOUR_IP -U login/pw -P login/pw raw 0x30 0x30 0x02 0xff 0x64
fi
