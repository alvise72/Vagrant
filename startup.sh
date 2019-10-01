#!/bin/bash

egrep 'linux[1-7]+' Vagrantfile|awk '{print $1}'|sed 's+\"++g'| xargs -P0 -I {} vagrant --storage-path=/gpfs/photonics/swissfel/res/dorigo_a/vbox --cores=1 --memory=1024 --disk-size=20 up {}
