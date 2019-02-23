#!/bin/bash
ssty -echo
source <(/usr/bin/resize -s)
/usr/bin/resize -s 29  38
ssty echo
./threes
ssty -echo
/usr/bin/resize -s $LINES $COLUMNS
