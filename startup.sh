#!/bin/bash

egrep 'linux[1-7]+' Vagrantfile|awk '{print $1}'|sed 's+\"++g'| xargs -P0 -I {} vagrant --storage-path=/gpfs/photonics/swissfel/res/dorigo_a/vbox --cores=4 --memory=16384 --disk-size=200 up {}
