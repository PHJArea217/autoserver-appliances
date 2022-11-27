#!/bin/sh
set -eu

openssl req -new -x509 -subj '/CN=server1/O=Autoserver, Peter Jin (.org)/' -newkey 'rsa:2048' -nodes -keyout rsa.key -out rsa.crt
openssl req -new -x509 -subj '/CN=server1/O=Autoserver, Peter Jin (.org)/' -newkey ec -pkeyopt 'ec_paramgen_curve:P-256' -nodes -keyout ecc.key -out ecc.crt
