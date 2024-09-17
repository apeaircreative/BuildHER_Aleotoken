program test_main.aleo {
    // On-chain storage for testing (similar to main.leo)
    mapping account: address => u64;

    /* Test Cases */

    // Test Case: Successful Public Mint
    async transition test_mint_public(public receiver: address) -> u8 {
        let mint_amount: u64 = 100u64;

        // Perform minting using the mint_public function from main.leo
        main.aleo/mint_public(receiver, mint_amount);

        // Verify the balance
        let balance: u64 = (await Mapping::get_or_use(account, receiver, 0u64));
        assert(balance == mint_amount, "Minting failed: Incorrect balance.");

        return 1u8;  // Test passed
    }

    // Test Case: Insufficient Funds for Transfer
    async transition test_transfer_insufficient_funds(public sender: address, public receiver: address) -> u8 {
        let transfer_amount: u64 = 100u64;

        // Attempt transfer without minting first
        main.aleo/transfer_public(sender, receiver, transfer_amount);

        // Expect failure, so sender's balance should be zero
        let sender_balance: u64 = (await Mapping::get_or_use(account, sender, 0u64));
        assert(sender_balance == 0u64, "Transfer should fail due to insufficient funds.");

        return 1u8;  // Test passed
    }

    // Test Case: Successful Public Transfer
    async transition test_transfer_public_success(public sender: address, public receiver: address) -> u8 {
        let mint_amount: u64 = 100u64;
        let transfer_amount: u64 = 50u64;

        // Mint to sender
        main.aleo/mint_public(sender, mint_amount);

        // Perform transfer
        main.aleo/transfer_public(sender, receiver, transfer_amount);

        // Verify balances
        let sender_balance: u64 = (await Mapping::get_or_use(account, sender, 0u64));
        let receiver_balance: u64 = (await Mapping::get_or_use(account, receiver, 0u64));

        assert(sender_balance == (mint_amount - transfer_amount), "Incorrect sender balance.");
        assert(receiver_balance == transfer_amount, "Incorrect receiver balance.");

        return 1u8;  // Test passed
    }

    // Test Case: Convert Public to Private Tokens
    async transition test_convert_public_to_private(public sender: address, public receiver: address) -> u8 {
        let mint_amount: u64 = 100u64;
        let convert_amount: u64 = 50u64;

        // Mint to sender
        main.aleo/mint_public(sender, mint_amount);

        // Convert tokens to private
        let (private_token, _) = main.aleo/transfer_public_to_private(sender, receiver, convert_amount);

        // Verify balances
        let sender_balance: u64 = (await Mapping::get_or_use(account, sender, 0u64));
        assert(sender_balance == (mint_amount - convert_amount), "Incorrect sender balance.");
        assert(private_token.amount == convert_amount, "Incorrect private token amount.");

        return 1u8;  // Test passed
    }

    // Test Case: Zero Amount Transfer
    async transition test_transfer_zero_amount(public sender: address, public receiver: address) -> u8 {
        let mint_amount: u64 = 100u64;
        let transfer_amount: u64 = 0u64;

        // Mint to sender
        main.aleo/mint_public(sender, mint_amount);

        // Attempt zero transfer
        main.aleo/transfer_public(sender, receiver, transfer_amount);

        // Verify balances
        let sender_balance: u64 = (await Mapping::get_or_use(account, sender, 0u64));
        let receiver_balance: u64 = (await Mapping::get_or_use(account, receiver, 0u64));

        assert(sender_balance == mint_amount, "Sender balance should remain unchanged.");
        assert(receiver_balance == 0u64, "Receiver balance should remain unchanged.");

        return 1u8;  // Test passed
    }
}
