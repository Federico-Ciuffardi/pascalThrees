#!/bin/bash
source <(/usr/bin/resize -s)
/usr/bin/resize -s 29  38
./threes
/usr/bin/resize -s $LINES $COLUMNS
