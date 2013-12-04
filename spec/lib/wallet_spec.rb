require_relative '../../lib/wallet'

describe Wallet do

  it "can get a balance" do
    wallet = Wallet.new
    wallet.balance.should >= 0
  end

end
