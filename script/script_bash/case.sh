#!/bin/bash
echo "What is your preferred team"
echo "1) Wales"
echo "2) Ireland"
echo "3) Scotland"
echo "4) England"
echo "5) Italy"
echo "6) France"
read case;
#simple case bash structure
# note in this case $case is variable and does not have to
# be named case this is just an example
case $case in
    1) echo "You selected Wales";;
    2) echo "You selected Ireland";;
    3) echo "You selected Scotland";;
    4) echo "You selected England";;
    5) echo "You selected Italy";;
    6) echo "You selected France";;
esac
