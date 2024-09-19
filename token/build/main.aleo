program token.aleo;

record token:
    owner as address.private;
    amount as u64.private;


mapping account:
	key as address.public;
	value as u64.public;


function mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    async mint_public r0 r1 into r2;
    output r2 as token.aleo/mint_public.future;

finalize mint_public:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use account[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into account[r0];



function mint_private:
    input r0 as address.private;
    input r1 as u64.private;
    cast r0 r1 into r2 as token.record;
    output r2 as token.record;



function transfer_public:
    input r0 as address.public;
    input r1 as u64.public;
    async transfer_public self.caller r0 r1 into r2;
    output r2 as token.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as address.public;
    input r2 as u64.public;
    get.or_use account[r0] 0u64 into r3;
    gte r3 r2 into r4;
    assert.eq r4 true;
    sub r3 r2 into r5;
    set r5 into account[r0];
    get.or_use account[r1] 0u64 into r6;
    add r6 r2 into r7;
    set r7 into account[r1];



function transfer_private:
    input r0 as token.record;
    input r1 as address.private;
    input r2 as u64.private;
    sub r0.amount r2 into r3;
    cast r0.owner r3 into r4 as token.record;
    cast r1 r2 into r5 as token.record;
    output r4 as token.record;
    output r5 as token.record;



function transfer_priv_to_pub:
    input r0 as token.record;
    input r1 as address.public;
    input r2 as u64.public;
    sub r0.amount r2 into r3;
    cast r0.owner r3 into r4 as token.record;
    async transfer_priv_to_pub r1 r2 into r5;
    output r4 as token.record;
    output r5 as token.aleo/transfer_priv_to_pub.future;

finalize transfer_priv_to_pub:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use account[r0] 0u64 into r2;
    add r2 r1 into r3;
    set r3 into account[r0];




function transfer_pub_to_priv:
    input r0 as address.public;
    input r1 as u64.public;
    cast r0 r1 into r2 as token.record;
    async transfer_pub_to_priv self.caller r1 into r3;
    output r2 as token.record;
    output r3 as token.aleo/transfer_pub_to_priv.future;

finalize transfer_pub_to_priv:
    input r0 as address.public;
    input r1 as u64.public;
    get.or_use account[r0] 0u64 into r2;
    gte r2 r1 into r3;
    assert.eq r3 true;
    sub r2 r1 into r4;
    set r4 into account[r0];

