#!/bin/bash

# First check that Leo is installed.
if ! command -v leo &> /dev/null
then
    echo "leo is not installed."
    exit
fi

# Check if an account argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 {account1|account2}"
    exit 1
fi

# Source the appropriate .env file based on the argument
if [ "$1" == "account1" ]; then
    export $(grep -v '^#' .env.account1 | xargs)  # Load Alice's environment variables
elif [ "$1" == "account2" ]; then
    export $(grep -v '^#' .env.account2 | xargs)  # Load Bob's environment variables
else
    echo "Invalid account specified. Use 'account1' or 'account2'."
    exit 1
fi

# Swap in the private key of Alice or Bob based on the account.
echo "
NETWORK=$NETWORK
PRIVATE_KEY=$PRIVATE_KEY
ENDPOINT=$ENDPOINT
" > .env

# Run the build process to ensure everything compiles before running tests
echo "###############################################################################"
echo "########                                                               ########"
echo "########                       BUILDING PROJECT                       ########"
echo "########                                                               ########"
echo "###############################################################################"

leo build
if [ $? -ne 0 ]; then
    echo "Build failed. Exiting."
    exit 1
fi

# Run Tests
echo "###############################################################################"
echo "########                                                               ########"
echo "########                       RUNNING TESTS                          ########"
echo "########                                                               ########"
echo "###############################################################################"

echo "Running test_mint_public..."
leo run test_mint_public --network testnet

echo "Running test_transfer_public..."
leo run test_transfer_public --network testnet

echo "Running test_transfer_pub_to_priv..."
leo run test_transfer_pub_to_priv --network testnet

# Publicly mint 100 tokens for Alice.
echo "
###############################################################################
########                                                               ########
########     STEP 1: Publicly mint 100 tokens for Alice                ########
########                                                               ########
###############################################################################
"
leo run mint_public $ADDRESS 100u64  # Use the address from the .env file

# Privately mint 100 tokens for Bob.
echo "
###############################################################################
########                                                               ########
########     STEP 2: Privately mint 100 tokens for Bob                 ########
########                                                               ########
###############################################################################
"
leo run mint_private $ADDRESS 100u64  # Use the address from the .env file

# Publicly transfer 10 tokens from Alice to Bob.
echo "
###############################################################################
########                                                               ########
########     STEP 3: Publicly transfer 10 tokens from Alice to Bob     ########
########                                                               ########
###############################################################################
"
leo run transfer_public $ADDRESS 10u64  # Use the address from the .env file

# Privately transfer 20 tokens from Bob to Alice.
echo "
###############################################################################
########                                                               ########
########     STEP 4: Privately transfer 20 tokens from Bob to Alice    ########
########                                                               ########
###############################################################################
"
leo run transfer_private "{ owner: $ADDRESS.private, amount: 100u64.private, _nonce: 6586771265379155927089644749305420610382723873232320906747954786091923851913group.public }" $ADDRESS 20u64  # Use the address from the .env file

# Convert 30 public tokens from Alice into 30 private tokens for Bob.
echo "
###############################################################################
########                                                               ########
########     STEP 5: Convert 30 public tokens from Alice into 30       ########
########             private tokens for Bob.                           ########
########                                                               ########
###############################################################################
"
leo run transfer_pub_to_priv $ADDRESS 30u64  # Use the address from the .env file

# Convert 40 private tokens from Bob into 40 public tokens for Alice.
echo "
###############################################################################
########                                                               ########
########     STEP 6: Convert 40 private tokens from Bob into 40        ########
########             public tokens for Alice.                          ########
########                                                               ########
###############################################################################
"
leo run transfer_priv_to_pub "{ owner: $ADDRESS.private, amount: 80u64.private, _nonce: 1852830456042139988098466781381363679605019151318121788109768539956661608520group.public }" $ADDRESS 40u64  # Use the address from the .env file

# Final message
echo "All operations completed successfully for $(whoami)."
