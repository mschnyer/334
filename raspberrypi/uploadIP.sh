#!/bin/bash

cd /home/student334/334/raspberrypi

hostname -I > ip.md
git add ip.md
git commit -m “new ip”
git push
