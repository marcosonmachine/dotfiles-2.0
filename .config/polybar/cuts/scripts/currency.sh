#! /bin/env bash
conversion="RUB-INR"

p=".config/polybar/cuts/scripts/finance/"
argtopy="$p""pinger.py"" $conversion"
python $argtopy 

cat conversion
