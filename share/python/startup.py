#!/user/bin/env python

import os
import sys

try:
    import readline
except ImportError:
    print "Module readline not available."
else:
    import rlcompleter
    readline.parse_and_bind("tab: complete")

histfile = os.path.join(
        os.path.dirname(os.environ['PYTHONSTARTUP']), 'histfile')
try:
    readline.read_history_file(histfile)
except IOError:
    pass
