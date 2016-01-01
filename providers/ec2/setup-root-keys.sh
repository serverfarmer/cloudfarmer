#!/bin/sh

cat /home/ubuntu/ssh.keys |sudo tee -a /root/.ssh/authorized_keys >/dev/null
