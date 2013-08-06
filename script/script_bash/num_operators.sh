#!/bin/bash
# declare integers
# -lt  = less than = <
# -gt  = greater than = >
# -le = less than or equal to  = <=
# -ge = greater than or equal to = >=
# -eq = equal to =    ==
# -ne = not equal to   !=
#  --------------------
NUM1=2
NUM2=2
if [ $NUM1 -eq $NUM2 ]; then
	echo "Both Values are equal"
else 
	echo "Values are NOT equal"
fi
#  --------------------
# another example
# NUM1=2
# NUM2=1
# if   [ $NUM1 -eq $NUM2 ]; then
# 	echo "Both Values are equal"
# elif [ $NUM1 -gt $NUM2 ]; then
# 	echo "NUM1 is greater then NUM2"
# else 
# 	echo "NUM2 is greater then NUM1"
# fi
#  --------------------