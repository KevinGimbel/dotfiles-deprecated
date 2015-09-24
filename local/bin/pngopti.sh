#!/bin/sh

args="$@"

for f in $args; do
  pngquant -v $f
done
