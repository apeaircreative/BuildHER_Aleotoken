program token.aleo;

// Define the token structure
record token:
    owner as address.private;  // The owner of the token
    amount as u64.private;      // The amount of tokens

// Mapping to store account balances
mapping account:
    key as address.public;      // Public address of the account
    value as u64.public;        // Balance of tokens in the account

// Function to mint tokens publicly
function mint_public:
    input r0 as address.public;  // Address of the account receiving the tokens
    input r1 as u64.public;       // Amount of tokens to mint
    async mint_public r0 r1 into r2;  // Mint the tokens asynchronously
    output r2 as token.aleo/mint_public.future;  // Output the future of the minting process

// Finalize the public minting process
finalize mint_public:
    input r0 as address.public;  // Address of the account receiving the tokens
    input r1 as u64.public;       // Amount of tokens to mint
    get.or_use account[r0] 0u64 into r2;  // Get current balance or default to 0
    add r2 r1 into r3;            // Add the minted amount to the current balance
    set r3 into account[r0];      // Update the account balance

// Function to mint tokens privately
function mint_private:
    input r0 as address.private;  // Address of the account receiving the tokens
    input r1 as u64.private;       // Amount of tokens to mint
    cast r0 r1 into r2 as token.record;  // Create a token record
    output r2 as token.record;     // Output the token record

// Function to transfer tokens publicly
function transfer_public:
    input r0 as address.public;  // Address of the account receiving the tokens
    input r1 as u64.public;       // Amount of tokens to transfer
    async transfer_public self.caller r0 r1 into r2;  // Transfer the tokens asynchronously
    output r2 as token.aleo/transfer_public.future;  // Output the future of the transfer process

// Finalize the public transfer process
finalize transfer_public:
    input r0 as address.public;  // Address of the account sending the tokens
    input r1 as address.public;  // Address of the account receiving the tokens
    input r2 as u64.public;       // Amount of tokens to transfer
    get.or_use account[r0] 0u64 into r3;  // Get current balance of sender
    if r3 < r2:
        output "Error: Insufficient funds for transfer." as string;  // Insufficient funds message
        return;  // Exit the function
    sub r3 r2 into r4;            // Subtract the transfer amount from sender's balance
    set r4 into account[r0];      // Update sender's balance
    get.or_use account[r1] 0u64 into r5;  // Get current balance of receiver
    add r5 r2 into r6;            // Add the transfer amount to receiver's balance
    set r6 into account[r1];      // Update receiver's balance

// Function to transfer tokens privately
function transfer_private:
    input r0 as token.record;     // Token record being transferred
    input r1 as address.private;   // Address of the account receiving the tokens
    input r2 as u64.private;       // Amount of tokens to transfer
    sub r0.amount r2 into r3;      // Subtract the transfer amount from the token record
    if r3 < 0:
        output "Error: Insufficient funds for private transfer." as string;  // Insufficient funds message
        return;  // Exit the function
    cast r0.owner r3 into r4 as token.record;  // Update the token record with new amount
    cast r1 r2 into r5 as token.record;  // Create a new token record for the receiver
    output r4 as token.record;     // Output the updated token record for the sender
    output r5 as token.record;     // Output the new token record for the receiver

// Function to convert private tokens to public
function transfer_private_to_public:
    input r0 as token.record;      // Token record being converted
    input r1 as address.public;     // Address of the account receiving the tokens
    input r2 as u64.public;         // Amount of tokens to convert
    sub r0.amount r2 into r3;       // Subtract the amount from the token record
    if r3 < 0:
        output "Error: Insufficient funds for conversion." as string;  // Insufficient funds message
        return;  // Exit the function
    cast r0.owner r3 into r4 as token.record;  // Update the token record
    async transfer_private_to_public r1 r2 into r5;  // Convert to public tokens
    output r4 as token.record;      // Output the updated token record for the sender
    output r5 as token.aleo/transfer_private_to_public.future;  // Output the future of the conversion

// Finalize the conversion from private to public
finalize transfer_private_to_public:
    input r0 as address.public;     // Address of the account receiving the tokens
    input r1 as u64.public;         // Amount of tokens to convert
    get.or_use account[r0] 0u64 into r2;  // Get current balance of receiver
    add r2 r1 into r3;              // Add the converted amount to receiver's balance
    set r3 into account[r0];        // Update receiver's balance

// Function to convert public tokens to private
function transfer_public_to_private:
    input r0 as address.public;     // Address of the account sending the tokens
    input r1 as u64.public;         // Amount of tokens to convert
    get.or_use account[r0] 0u64 into r2;  // Get current balance of sender
    if r2 < r1:
        output "Error: Insufficient funds for conversion." as string;  // Insufficient funds message
        return;  // Exit the function
    cast r0 r1 into r3 as token.record;  // Create a token record for the sender
    async transfer_public_to_private self.caller r1 into r4;  // Convert to private tokens
    output r3 as token.record;      // Output the token record for the sender
    output r4 as token.aleo/transfer_public_to_private.future;  // Output the future of the conversion

// Finalize the conversion from public to private
finalize transfer_public_to_private:
    input r0 as address.public;     // Address of the account sending the tokens
    input r1 as u64.public;         // Amount of tokens to convert
    get.or_use account[r0] 0u64 into r2;  // Get current balance of sender
    sub r2 r1 into r3;              // Subtract the amount from sender's balance
    set r3 into account[r0];        // Update sender's balance