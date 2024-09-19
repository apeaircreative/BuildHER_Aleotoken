import token.aleo;

program test_token.aleo {

    // Test function for mint_public
    async function test_mint_public:
        input r0 as address.public;
        input r1 as u64.public;
        async token.aleo/mint_public r0 r1 into r2;
        output r2 as token.aleo/mint_public.future;

    // Test function for transfer_public
    async function test_transfer_public:
        input r0 as address.public;
        input r1 as address.public;
        input r2 as u64.public;
        async token.aleo/transfer_public r0 r2 into r3;
        output r3 as token.aleo/transfer_public.future;

    // Test function for transfer_private_to_public
    async function test_transfer_priv_to_pub:
        input r0 as token.record;
        input r1 as address.public;
        input r2 as u64.public;
        async token.aleo/transfer_private_to_public r0 r1 r2 into r3;
        output r3 as token.aleo/transfer_private_to_public.future;

    // Test function for transfer_public_to_private
    async function test_transfer_pub_to_priv:
        input r0 as address.public;
        input r1 as u64.public;
        async token.aleo/transfer_public_to_private r0 r1 into r2;
        output r2 as token.aleo/transfer_public_to_private.future;
}
