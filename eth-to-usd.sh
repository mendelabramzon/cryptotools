#!/bin/bash

# Set the CoinMarketCap API key
API_KEY=""

# Set the symbol and conversion currency
SYMBOL="ETH"
CONVERT="USD"

# Get the amount of ETH from the first command-line argument
AMOUNT=$1

# Use curl and jq to get the ETH to USD price
PRICE=$(curl -s -H "X-CMC_PRO_API_KEY: $API_KEY" -H "Accept: application/json" -d "symbol=$SYMBOL&convert=$CONVERT" -G https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest | jq -r '.data | .ETH.quote.USD.price')

# Calculate the USD value of the given amount of ETH
VALUE=$(echo "$AMOUNT * $PRICE" | bc)

# Round the USD value up to the nearest 0.1
VALUE_ROUNDED=$(printf "%.1f" $(echo "scale=1;($VALUE+0.05)" | bc))

# Output the result
echo "$AMOUNT $SYMBOL = $VALUE_ROUNDED $CONVERT"
