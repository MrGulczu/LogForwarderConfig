#!/usr/bin/env bash

for file in /var/log/remote_logs/*.log; do : > $file; done


