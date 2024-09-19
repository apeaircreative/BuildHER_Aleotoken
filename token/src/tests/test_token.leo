import token.aleo;

program test_token.aleo {
    // Test function for mint_public
    function test_mint_public(receiver: address, amount: u64) {
        let result: Future = token.aleo/mint_public(receiver, amount);
    }

    // Test function for transfer_public
    function test_transfer_public(sender: address, receiver: address, amount: u64) {
        let result: Future = token.aleo/transfer_public(receiver, amount);
    }

    // Test function for transfer_private_to_public
    function test_transfer_priv_to_pub(sender: token, receiver: address, amount: u64) {
        let result: Future = transfer_priv_to_pub(sender, receiver, amount);
    }

    // Test function for transfer_public_to_private
    function test_transfer_pub_to_priv(sender: address, receiver: address, amount: u64) {
        let result: Future = transfer_pub_to_priv(receiver, amount);
    }
}