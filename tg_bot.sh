#!/bin/bash

#TODO: Make an array of different groups to randomly flip in to confuse regulation

tg_group1=test_bot
tg_group2=Pleb_Gamble

n_participants=3

bet_size_procent=5

startbag=10000

n_flips=0

while [ true ]
do

#Double /balance but otherwise it doesent work for some reason
telegram-cli -W -e "msg lntxbot /balance"
sleep 2s
terminal_print=$(telegram-cli -W -e "msg lntxbot /balance" | grep "Balance:")
sleep 2s

#Split output from terminalwindow and pick the balance at line 3
IFS=':.' read -ra my_array <<< "$terminal_print"
sat_balance="${my_array[2]}"

#Choose what % of your bag you wanna bet
bet_size=$(($sat_balance*$bet_size_procent/100))
sleep 2s

#Send evil message
telegram-cli -W -e "msg $tg_group2 optimus_cp1.0 will rek yu"
sleep 2s

#Make the flip
telegram-cli -W -e "msg $tg_group2 /coinflip $bet_size $n_participants"
sleep 2s

((n_flips++))

echo "Balance --> $sat_balance satoshis"
echo "Bet --> $bet_size satoshis"
echo "Gains --> $(($sat_balance - $startbag)) satoshis"
echo "Total flips --> "$n_flips

#Wait 31m because of regulation
sleep 31m

done

