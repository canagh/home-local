set history save on
set history size 10000
set history filename ~/.gdb_history
set print pretty on
set print static-members off
set charset ASCII

# svn copy svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python
python
import os, sys
sys.path.insert(0, os.environ['HOME'] + '/lib/stlsupport/')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end
