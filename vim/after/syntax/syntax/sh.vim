" #/bin/sh
syntax match Error /^#\/\(usr\/\)\?bin\/\(ba\)\?sh\s*$/

" echo paths
syntax match Error /^\s*echo\s\+<<\(EOF\|'EOF'\|"EOF"\)/
syntax match Error /^\s*echo\s\+<(.*)/
