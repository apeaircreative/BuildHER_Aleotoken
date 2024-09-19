program token.aleo {

    // On-chain storage of an `account` map, with `address` as the key,
    // and `u64` as the value.
    mapping account: address => u64;

    record token {
        // The token owner.
        owner: address,
        // The token amount.
        amount: u64,
    }

    /* Mint */

    // The function `mint_public` issues the specified token amount for the token receiver publicly on the network.
    async transition mint_public(public receiver: address, public amount: u64) -> Future {
        return finalize_mint_pub(receiver, amount);
    }

    async function finalize_mint_pub(public receiver: address, public amount: u64) {
        let current_amount: u64 = Mapping::get_or_use(account, receiver, 0u64);
        Mapping::set(account, receiver, current_amount + amount);
    }

    // The function `mint_private` initializes a new record with the specified amount of tokens for the receiver.
    transition mint_private(receiver: address, amount: u64) -> token {
        return token {
            owner: receiver,
            amount: amount,
        };
    }

    /* Transfer */
    async transition transfer_public(public receiver: address, public amount: u64) -> Future {
        return finalize_transfer_pub(self.caller, receiver, amount);
    }

    async function finalize_transfer_pub(public sender: address, public receiver: address, public amount: u64) {
        let sender_amount: u64 = Mapping::get_or_use(account, sender, 0u64);
        assert(sender_amount >= amount);
        Mapping::set(account, sender, sender_amount - amount);
        
        let receiver_amount: u64 = Mapping::get_or_use(account, receiver, 0u64);
        Mapping::set(account, receiver, receiver_amount + amount);
    }

    // The function `transfer_private` sends the specified token amount to the token receiver from the specified token record.
    transition transfer_private(sender: token, receiver: address, amount: u64) -> (token, token) {
        let difference: u64 = sender.amount - amount;

        let remaining: token = token {
            owner: sender.owner,
            amount: difference,
        };

        let transferred: token = token {
            owner: receiver,
            amount: amount,
        };

        return (remaining, transferred);
    }

    // The function `transfer_private_to_public` turns a specified token amount from a token record into public tokens for the specified receiver.
    async transition transfer_priv_to_pub(sender: token, public receiver: address, public amount: u64) -> (token, Future) {
        let difference: u64 = sender.amount - amount;

        let remaining: token = token {
            owner: sender.owner,
            amount: difference,
        };

        return (remaining, finalize_transfer_priv_to_pub(receiver, amount));
    }

    async function finalize_transfer_priv_to_pub(public receiver: address, public amount: u64) {
        let current_amount: u64 = Mapping::get_or_use(account, receiver, 0u64);
        Mapping::set(account, receiver, current_amount + amount);
    }

    // The function `transfer_public_to_private` turns a specified token amount from `account` into a token record for the specified receiver.
    async transition transfer_pub_to_priv(public receiver: address, public amount: u64) -> (token, Future) {
        let transferred: token = token {
            owner: receiver,
            amount: amount,
        };

        return (transferred, finalize_transfer_pub_to_priv(self.caller, amount));
    }

    async function finalize_transfer_pub_to_priv(public sender: address, public amount: u64) {
        let current_amount: u64 = Mapping::get_or_use(account, sender, 0u64);
        assert(current_amount >= amount);
        Mapping::set(account, sender, current_amount - amount);
    }
}
