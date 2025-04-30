#!/bin/bash

# Script to register pairs for DelphiOracle using cleos

# Configuration - modify these values as needed
ACCOUNT="blockmatic"      # Your account that will register the pairs
CONTRACT="delphioracle"    # The DelphiOracle contract account
PERMISSION="active"        # Permission to use for the transactions
API_ENDPOINT="https://api.np.animus.is"  # API endpoint
DELAY_SECONDS=2           # Delay between API calls to avoid rate limits

# Function to register a pair
register_pair() {
  local pair=$1
  # Remove quotes if they exist
  pair=$(echo $pair | tr -d '"')
  
  echo "Registering pair: $pair"

  # Set default values
  local base_precision=4
  local quote_precision=2
  local base_contract="eosio.token"
  local base_type=0
  local quote_type=1
  local quote_contract=""
  
  # Set values based on the pair
  case "$pair" in
    "usdtars")
      base_symbol="USDT"
      quote_symbol="ARS"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "usdtcrc")
      base_symbol="USDT"
      quote_symbol="CRC"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "usdtmxn")
      base_symbol="USDT"
      quote_symbol="MXN"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "usdteur")
      base_symbol="USDT"
      quote_symbol="EUR"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "usdtaud")
      base_symbol="USDT"
      quote_symbol="AUD"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "usdtcad")
      base_symbol="USDT"
      quote_symbol="CAD"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "usdtcop")
      base_symbol="USDT"
      quote_symbol="COP"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "usdtgbp")
      base_symbol="USDT"
      quote_symbol="GBP"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "usdtkrw")
      base_symbol="USDT"
      quote_symbol="KRW"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "usdtjpy")
      base_symbol="USDT"
      quote_symbol="JPY"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "usdtvnd")
      base_symbol="USDT"
      quote_symbol="VND"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "usdttwd")
      base_symbol="USDT"
      quote_symbol="TWD"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "usdtthb")
      base_symbol="USDT"
      quote_symbol="THB"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "usdtsol")
      base_symbol="USDT"
      quote_symbol="SOL"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "usdtclp")
      base_symbol="USDT"
      quote_symbol="CLP"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "usdtcny")
      base_symbol="USDT"
      quote_symbol="CNY"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "usdtidr")
      base_symbol="USDT"
      quote_symbol="IDR"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "usdtmyr")
      base_symbol="USDT"
      quote_symbol="MYR"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "usdtngn")
      base_symbol="USDT"
      quote_symbol="NGN"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "usdtugx")
      base_symbol="USDT"
      quote_symbol="UGX"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "usdtkes")
      base_symbol="USDT"
      quote_symbol="KES"
      base_precision=4
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "eosusdt")
      base_symbol="EOS"
      quote_symbol="USDT"
      base_precision=4
      quote_precision=4
      base_type=4
      quote_type=4
      quote_contract=""
      ;;
    "ethusd")
      base_symbol="PETH"
      quote_symbol="USD"
      base_precision=9
      quote_precision=2
      base_type=4
      base_contract=""
      quote_contract=""
      ;;
    "btcusd")
      base_symbol="BTC"
      quote_symbol="USD"
      base_precision=8
      quote_precision=2
      base_type=2
      base_contract=""
      quote_contract=""
      ;;
    "eosbtc")
      base_symbol="EOS"
      quote_symbol="BTC"
      base_precision=4
      quote_precision=8
      base_type=4
      quote_type=2
      base_contract=""
      quote_contract=""
      ;;
    *)
      echo "Unknown pair: $pair, using defaults"
      base_symbol="UNKNOWN"
      quote_symbol="UNKNOWN"
      ;;
  esac
  
  # Create the JSON payload
  json_data="{
    \"proposer\": \"$ACCOUNT\",
    \"pair\": {
      \"name\": \"$pair\",
      \"base_symbol\": {
        \"sym\": \"${base_precision},${base_symbol}\"
      },
      \"quote_symbol\": {
        \"sym\": \"${quote_precision},${quote_symbol}\"
      },
      \"base_type\": $base_type,
      \"quote_type\": $quote_type,
      \"base_contract\": \"$base_contract\",
      \"quote_contract\": \"$quote_contract\",
      \"quoted_precision\": $base_precision
    }
  }"
  
  echo "Sending transaction with payload:"
  echo "$json_data"
  
  # Execute the cleos command and capture result
  result=$(cleos -u $API_ENDPOINT push action $CONTRACT newbounty "$json_data" -p $ACCOUNT@$PERMISSION 2>&1)
  status=$?
  
  # Check if the command was successful
  if [ $status -eq 0 ]; then
    echo "✅ Successfully registered pair: $pair"
  else
    echo "❌ Failed to register pair: $pair"
    echo "Error: $result"
  fi
  
  # Add a delay to avoid rate limits
  echo "Waiting ${DELAY_SECONDS} seconds before next transaction..."
  sleep $DELAY_SECONDS
}

# Main function
main() {
  # Get pairs from get-pairs.sh
  declare -a pairs=(
    "usdtars" "usdtcrc" "usdtmxn" "usdteur" "usdtaud" "usdtcad"
    "usdtcop" "usdtgbp" "usdtkrw" "usdtjpy" "usdtvnd" "usdttwd"
    "usdtthb" "usdtsol" "usdtclp" "usdtcny" "usdtidr" "usdtmyr"
    "usdtngn" "usdtugx" "usdtkes" "eosusdt" "ethusd" "btcusd"
    "eosbtc"
  )
  
  echo "Starting pair registration process..."
  echo "Found ${#pairs[@]} pairs to register"
  
  # Process pairs
  for pair in "${pairs[@]}"; do
    register_pair "$pair"
  done
  
  echo "Completed pair registration process."
  
  # Verify registrations
  echo "Verifying registered pairs..."
  cleos -u $API_ENDPOINT get table $CONTRACT $CONTRACT pairs
}

# Execute the main function
main 