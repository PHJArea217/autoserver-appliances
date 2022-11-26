#!/bin/sh
for repo in ctrtool-containers ctrtool-config_tars universal-relay; do git clone "$1/$repo"; done
