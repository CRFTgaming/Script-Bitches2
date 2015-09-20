#!/bin/bash

# Prints out X & Y position for each delivery point (DP) in the mission.sqm file
# [Woody]

FILE=mission.sqm

for LINES in `grep 'text="dp_' mission.sqm -n | cut -d: -f1`
do
        Mission=`head -n $LINES $FILE | tail -1`
        MissName=`echo $Mission | cut -d'"' -f2`
        if [ "${MissName}" = "dp_7" -o  "${MissName}" = "dp_17" ]
        then
                CoOrd=`expr $LINES - 8`
        else
                CoOrd=`expr $LINES - 7`
        fi

        FullCoOrd=`head -n $CoOrd $FILE | tail -1`
        StripCoOrd=`echo $FullCoOrd | cut -d'{' -f2`

         
        # echo -e "${MissName}\t${StripCoOrd}"

        # StripCoOrd contains full coordinates, we only need six digits.
        Xcord=`echo ${StripCoOrd} | cut -d',' -f1 | cut -c1-3`
        Ycord=`echo ${StripCoOrd} | cut -d',' -f3 | cut -c1-3`

        echo -e "${MissName}\t${Xcord},${Ycord}"
done
