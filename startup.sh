#!/bin/bash

#seq 1 7| xargs -n1 -P7 -I{} vagrant --storage-path=/gpfs/photonics/swissfel/res/dorigo_a/vbox --cores=4 --memory=8192 up linux{}

# Startup ansible nodes @Home
# vagrant --storage-path=/Volumes/Home/Virtual\ Machines.localized --cores=1 --memory=2048 up control
# vagrant --storage-path=/Volumes/Home/Virtual\ Machines.localized --cores=1 --memory=2048 up managed
for i in control server1 server2 server3 server4; do echo $i; done|xargs -n1 -P7 -I{} vagrant up {}
