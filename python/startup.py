#!/usr/bin/env python

import os
import sys

try:
    import readline
except ImportError:
    sys.stdout.write("Module readline not available.")
else:
    import rlcompleter
    readline.parse_and_bind("tab: complete")
    # histfile
    histfile = os.path.join(os.environ['HOME'], 'local', 'python.history')
    try:
        readline.read_history_file(histfile)
    except IOError:
        pass
    import atexit
    atexit.register(readline.write_history_file, histfile)
    del histfile

import argparse
import subprocess
import re
import random
import math
import itertools
import functools
import operator
import struct
import time
import telnetlib
import socket
import string
