#!/bin/bash

cleos set account permission delphioracle active --add-code
cleos push action delphioracle configure  "$(cat configure.json)" -p delphioracle
