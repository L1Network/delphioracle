#!/bin/bash

# Simple script to get all rows for all pairs from DelphiOracle contract

# Configuration
CONTRACT="delphioracle"
API_ENDPOINT="https://eos.api.eosnation.io"

# List of pairs to check (from the image)
declare -a pairs=(
  "usdtars" "usdtcrc" "usdtmxn" "usdteur" "usdtaud" "usdtcad"
  "usdtcop" "usdtgbp" "usdtkrw" "usdtjpy" "usdtvnd" "usdttwd"
  "usdtthb" "usdtsol" "usdtclp" "usdtcny" "usdtidr" "usdtmyr"
  "usdtngn" "usdtugx" "usdtkes" "eosusdt" "ethusd" "btcusd"
  "eosbtc"
)

# Get all rows for all pairs
echo "Getting all pairs from the pairs table by name..."
echo

for pair in "${pairs[@]}"; do
  pair=$(echo $pair | tr -d '"')
  echo "Searching for pair: $pair"
  echo "----------------------------------------"
  # Search the pairs table using the name index (index 2)
  # echo "Command: cleos -u $API_ENDPOINT get table $CONTRACT $CONTRACT pairs --limit 1 --lower \"$pair\""
  cleos -u $API_ENDPOINT get table $CONTRACT $CONTRACT pairs --limit 1 --lower "$pair"
  echo "----------------------------------------"
  echo
done

echo "Completed fetching data for all pairs." 