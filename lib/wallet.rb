require 'bitcoin'
require 'uri'

require 'dotenv'
Dotenv.load

class Wallet

  def wallet_url
    ENV['wallet_url']
  end

  def wallet
    uri = URI.parse(ENV['wallet_url'])
    @wallet ||= Bitcoin::Client.new(ENV['rpc_username'], ENV['rpc_password'], host: uri.host, port: uri.port)
  end

  def balance
    wallet.balance
  end

end
