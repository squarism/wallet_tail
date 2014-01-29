require 'bitcoin'
require 'uri'

class Wallet

  def wallet_url
    ENV['wallet_url']
  end

  def rpc_username
    ENV['rpc_username']
  end

  def rpc_password
    ENV['rpc_password']
  end

  def wallet
    uri = URI.parse(wallet_url)
    @wallet ||= Bitcoin::Client.new(
        rpc_username,
        rpc_password,
        host: uri.host,
        port: uri.port
      )
  end

  def balance
    wallet.balance
  end

  def last_transaction
    wallet.transactions("").select {|t| t["category"] == "generate" }.last
  end

  def difficulty
    wallet.getdifficulty
  end

end
