set history save on
set history size 10000
set history filename ~/.gdb_history
set print pretty on
set print static-members off
set charset ASCII
set disassembly-flavor intel
# source /usr/share/peda/peda.py
source ~/lib/peda/peda.py
define heap
    python from libheap import *
end
