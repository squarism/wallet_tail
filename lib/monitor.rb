require_relative 'notifier'
require_relative 'wallet'

class Monitor

  def sleep_time
    300
  end

  def wallet_balance
    balance = nil

    begin
      balance = wallet.balance
    rescue RestClient::RequestTimeout => e
      puts e.message
      sleep sleep_time
      retry
    rescue Errno::ECONNREFUSED => e
      puts e.message
      sleep sleep_time
      retry
    end

    balance
  end

  def start
    puts "Starting Wallet Tail.  I'll tell you when your balance changes."
    @running = true
    @last_balance = wallet_balance
    sleep 5

    while @running do
      newest_balance = wallet_balance

      if newest_balance != @last_balance
        puts "--- WALLET CHANGE --- Notifying Growl of new balance: #{newest_balance} ..."
        notifier.annoy "New Balance: #{newest_balance}"
      end

      @last_balance = newest_balance
      sleep sleep_time
    end
  end

  def wallet
    @wallet ||= Wallet.new
  end

  def notifier
    @notifier ||= Notifier.new
  end

  def stop
    puts "Stopping ..."
    @running = false
  end

  def load_profile(name)
    if name
      begin
        Dotenv.load!(File.expand_path("../../conf/#{name}.conf", __FILE__))
      rescue Errno::ENOENT
        puts "No configuration in conf/ named #{name}!"
        puts "Please follow the README.\n\n"
        raise ArgumentError
      end
    else
      # if they didn't say what profile to watch then just grab the first one
      # maybe they just have one wallet?
      first_file = Dir.glob("conf/*.conf").first
      Dotenv.load first_file
    end
  end

end
