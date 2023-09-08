#!/bin/bash

hostname -I > ip.md
git add .
git commit -m “new ip”
git push
