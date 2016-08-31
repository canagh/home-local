REPORTTIME=8
ulimit -Sv `cat /proc/meminfo | grep MemTotal | awk '{ print $2 / 2 }'` # address space, half of the total
