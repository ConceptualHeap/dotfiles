#!/bin/bash

if pgrep -x "hyprsunset" > /dev/null; then
  killall -9 hyprsunset
else 
  hyprsunset
fi
