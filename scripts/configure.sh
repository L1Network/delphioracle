#!/bin/zsh

cleos1 set account permission delphioracle active --add-code
cleos1 push action delphioracle configure  "$(cat configure.json)" -p delphioracle
