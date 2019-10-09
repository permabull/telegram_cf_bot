#!/bin/bash

tg_group1=Pleb_Gamble

n_participants=3
startbag=0
old_sat_balance=0
n_flips=0

function set_bet_size() {
  if [ $new_sat_balance -lt $old_sat_balance ]
  then
    ((bet_size_procent++))
  else
    bet_size_procent=3
  fi
}

function giveflip() {
  if (( $n_flips % 100 == 0 ))
  then
    telegram-cli -W -e "msg $tg_group1 To celebrate my "$n_flips"th flip Im giving away 💲3000💲 satoshis 💥🎲D4L🎲💥"
    telegram-cli -W -e "msg $tg_group1 /giveflip 3000 4"
    sleep 5m
  fi
}

while [ true ]
do
  #giveflip

  telegram-cli -W -e "msg lntxbot /balance"
  sleep 2s

  terminal_print=$(telegram-cli -W -e "msg lntxbot /balance" | grep "Balance:")
  sleep 2s

  IFS=':.' read -ra my_array <<< "$terminal_print"
  new_sat_balance="${my_array[2]}"
  sleep 2s

  set_bet_size

  bet_size=$(($new_sat_balance*$bet_size_procent/100))
  sleep 2s

  telegram-cli -W -e "msg $tg_group1 all your satoshis are belong to me🔫"
  sleep 1s
  telegram-cli -W -e "msg $tg_group1 💥DGL:$bet_size_procent💥🎲FLIPS:$n_flips🎲💲GAINS:$(( 100 * new_sat_balance / startbag + (1000 * new_sat_balance / startbag % 10 >= 5 ? 1 : 0)-100 ))%💲"
  sleep 2s

  telegram-cli -W -e "msg $tg_group1 /coinflip $bet_size $n_participants"
  sleep 2s

  old_sat_balance=$new_sat_balance

  echo "Degenlevel --> $bet_size_procent%"
  echo "Balance --> $new_sat_balance satoshis"
  echo "Bet --> $bet_size satoshis"
  echo "Gains --> $(($new_sat_balance - $startbag)) satoshis"
  echo "Flips : $n_flips"

  ((n_flips++))

  sleep 60m
done
