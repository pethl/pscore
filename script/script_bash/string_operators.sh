#!/bin/bash
# declare integers
# = equal
# != not equal
# < less than
# > greater than
# -n s1 = string s1 is not empty
#  -z s1  = string s1 is empty
#  --------------------

#Declare string S1
S1="Bash"
#Declare string S2
S2="Scripting"
if [ $S1 = $S2 ]; then
	echo "Both Strings are equal"
else 
	echo "Strings are NOT equal"
fi
#  --------------------
# another example
# !/bin/bash
# Declare string S1
# S1="Bash"
# Declare string S2
# S2="Bash"
# if [ $S1 = $S2 ]; then
# 	echo "Both Strings are equal"
# else 
# 	echo "Strings are NOT equal"
# fi
#  --------------------