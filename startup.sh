#!/bin/bash

egrep 'linux[0-9]+' Vagrantfile|awk '{print $1}'|sed 's+\"++g'| xargs -P0 -I {} vagrant up {}
