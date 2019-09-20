#!/bin/bash

tg_group2=Pleb_Gamble

n_participants=3
startbag=10000
old_sat_balance=0
n_flips=-1

function set_bet_size() {
  if [ $new_sat_balance -lt $old_sat_balance ]
  then
    ((bet_size_procent++))
  else
    bet_size_procent=5
  fi
}

while [ true ]
do
  telegram-cli -W -e "msg lntxbot /balance"
  sleep 2s

  terminal_print=$(telegram-cli -W -e "msg lntxbot /balance" | grep "Balance:")
  sleep 2s

  IFS=':.' read -ra my_array <<< "$terminal_print"
  new_sat_balance="${my_array[2]}"

  set_bet_size

  bet_size=$(($new_sat_balance*$bet_size_procent/100))
  sleep 2s

  telegram-cli -W -e "msg $tg_group2 optimus_cp0.2🤖(DGL:$bet_size_procent) will rek yu"
  sleep 2s

  telegram-cli -W -e "msg $tg_group2 /coinflip $bet_size $n_participants"
  sleep 2s

  old_sat_balance=$new_sat_balance

  ((n_flips++))

  echo "Degenlevel --> $bet_size_procent%"
  echo "Balance --> $new_sat_balance satoshis"
  echo "Bet --> $bet_size satoshis"
  echo "Gains --> $(($new_sat_balance - $startbag)) satoshis"
  echo "Flips : $n_flips"

  sleep 31m
done
