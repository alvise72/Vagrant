#!/bin/bash

seq 1 7| xargs -n1 -P7 -I{} vagrant --storage-path=/gpfs/photonics/swissfel/res/dorigo_a/vbox --cores=4 --memory=8192 up linux{}
