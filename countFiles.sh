#!/bin/bash

ls -Al $1 | tail -n+2 | grep -v "^d" | grep "$2$" | wc -l
