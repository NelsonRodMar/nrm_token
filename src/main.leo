// The 'nrm_token' program.
program nrm_token.aleo {
    record Token {
        owner: address;
        balance: u32;
    }

    transition mint(balance: u32) -> Token  {
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
