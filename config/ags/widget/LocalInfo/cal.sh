#!/usr/bin/env bash

# TODO: turn this into generate-cal.sh
# that takes in a year & month (YYYY-MM) and
# gives necessary info to render it

yearMonth=$(date "+%Y-%m")
firstDayOfMonth="$yearMonth-01"
dayOfWeekOffset=$(date --date="${firstDayOfMonth}" "+%w")

firstDayNum=$(dateadd ${firstDayOfMonth} -${dayOfWeekOffset}d -f %d)
monthLen=$(dateadd ${firstDayOfMonth} +1mo -1d -f %d)

echo "${dayOfWeekOffset} ${firstDayNum} ${monthLen}"
