#!/bin/bash
# Waybar status for Cooler Boost. Prints one JSON line.
state=$(coolerboost status 2>/dev/null)
case "$state" in
  on)  printf '{"text":"\xf3\xb0\x88\x90","class":"on","tooltip":"Cooler Boost: ON (click to turn off)"}\n' ;;
  off) printf '{"text":"\xf3\xb0\xa0\x9d","class":"off","tooltip":"Cooler Boost: off (click to turn on)"}\n' ;;
  *)   printf '{"text":"?","class":"error","tooltip":"coolerboost status failed"}\n' ;;
esac
