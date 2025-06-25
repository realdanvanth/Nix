#!/bin/bash

PID=$(pgrep -x gammastep)

if [ -n "$PID" ]; then
    kill "$PID"
else
    gammastep -O 3500 &
fi

