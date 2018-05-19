# Python Version: 2.x / 3.x

import os
import sys

try:
    import readline
except ImportError:
    sys.stdout.write("Module readline not available.")
else:
    import rlcompleter
    readline.parse_and_bind("tab: complete")
    histfile = os.path.join(os.environ['HOME'], '.python_history')
    try:
        readline.read_history_file(histfile)
    except IOError:
        pass
    import atexit
    atexit.register(readline.write_history_file, histfile)
    del histfile

import argparse
import base64
import binascii
import functools
import hashlib
import itertools
import math
import operator
import random
import re
import socket
import string
import struct
import subprocess
import telnetlib
import time

try:
    import Crypto
    import Crypto.PublicKey
    import Crypto.PublicKey.RSA
except ImportError:
    pass

try:
    import numpy as np
except ImportError:
    pass

try:
    from sympy.functions.combinatorial.factorials import binomial
    from sympy.functions.combinatorial.factorials import factorial
    from sympy.functions.combinatorial.numbers import fibonacci
except ImportError:
    pass

try:
    import gmpy2
except ImportError:
    pass

if sys.version_info.major == 3:
    import urllib.parse
    import urllib.request

if sys.version_info.major == 2:
    try:
        import pwnlib
        from pwnlib.util.packing import p8, p16, p32, p64
        from pwnlib.util.packing import u8, u16, u32, u64
    except ImportError:
        pass
