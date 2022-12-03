#!/bin/sh
exec nsenter --net=/run/netns/__host__ pdns_server
