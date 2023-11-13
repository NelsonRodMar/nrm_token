// The 'nrm_token' program.
program nrm_token.aleo {
    record Token {
        owner: address;
        balance: u32;
    }

    // Only us can mint tokens.
    transition mint(balance: u32) -> Token  {
        assert_eq(self.caller, aleo1zpsr2qlhxwarg8j3tjtv4rusd2muld7aj5fzrt8dvqz263n6xgqqe9ps3j);
         return  Token {
                owner: self.caller,
                balance: balance
            };
    }

    transition transfer(receiver: address, amount: u32, input: Token) -> (Token, Token) {
        assert(amount <= input.balance);
        let balance: u32 = input.balance - amount;
        let recipient: Token = Token {
            owner: receiver,
            balance: amount
        };
        let sender: Token = Token {
            owner: self.caller,
            balance: balance
        };
        return (sender, recipient);
    }
}
