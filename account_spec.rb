require "rspec"

require_relative "account"

describe Account do
  
  let(:account) { Account.new("0123456789", 1000 ) }
 
  describe "#initialize" do
    
    let(:account) { Account.new } 
    
    it "should require one argument" do
      expect { Account.new }.to raise_error(ArgumentError)
    end

    it "should require a numeric argument" do
      expect { Account.new("ASS")}.to raise_error(InvalidAccountNumberError)
    end

    it "should require 10 character length" do
      expect { Account.new("012345") }.to raise_error(InvalidAccountNumberError)
    end

    it "should be valid without starting balance" do
      expect { Account.new("0123456789") }.not_to raise_error
    end

    it "should be valid with starting balance" do
      expect { Account.new("0123456789", 1000) }.not_to raise_error
    end
  end

  describe "#transactions" do
    it "should return an array with length one" do
      expect account.transactions.class == Array
      expect(account.transactions.length).to eq 1
    end
  end

  describe "#balance" do
    it "should return 1000" do
      expect account.balance == 1000
    end
  end

  describe "#account_number" do
    it "should be 6 *'s and 4 digits" do
      expect(account.acct_number).to match /^*{6}\d{4}$/
    end
  end

  describe "deposit!" do
    it "should add transaction to desposit a positive number" do
      account.deposit!(100)
      expect(account.transactions.length).to eq 2
    end  

    it "should raise an error when depositing a negative number" do
      expect {account.deposit!(-100) }.to raise_error(NegativeDepositError)
    end
  end

  describe "#withdraw!" do
    it "should add transaction to remove less than the total balance" do
      account.withdraw!(100)
      expect(account.transactions.length).to eq 2
    end

    it "should raise overdraft error when adding transaction removing more than the total balance" do
      expect {account.withdraw!(1100) }.to raise_error(OverdraftError)
    end
  end
end
