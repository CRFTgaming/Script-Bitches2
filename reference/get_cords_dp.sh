#!/bin/bash

# Spits out X & Y position for each delivery point (DP) in the mission.sqm file
# Relies on hardcoded inconsistentces to work and is held together with chewing gum and string
# but it was quicker to write this than visit each DP on the map and manually write out the coordinates!
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

        # Get only the DP number
        DpNum=`echo ${MissName} | cut -d'_' -f2`

        # Test to ensure that it is numeric
        if [ "${DpNum}" -eq "${DpNum}" ] 2>/dev/null
        then
                PadDpNum=`printf "%0*d\n" 2 $DpNum`
        else
                PadDpNum=00
        fi

        # StripCoOrd contains full coordinates, we only need six digits.
        Xcord=`echo ${StripCoOrd} | cut -d',' -f1 | cut -c1-3`
        Ycord=`echo ${StripCoOrd} | cut -d',' -f3 | cut -c1-3`

        echo -e "DP${PadDpNum}\t${Xcord},${Ycord}"
done | sort
