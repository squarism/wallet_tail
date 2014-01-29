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

  def wallet_last_transaction
    wallet.last_transaction
  end

  def time_format(time)
    time.strftime('%Y-%m-%d') + " " + time.zone
  end

  def start
    puts "\"I'll tell you when you find blocks.\""
    puts "   -- Wallet Tail"

    # initial states
    @running = true
    @last_balance = wallet_balance
    @last_transaction = wallet_last_transaction

    sleep 5  # initial boot sleep time

    while @running do
      if wallet_changed?(@last_transaction, wallet_last_transaction)
        time = Time.at(wallet_last_transaction['time'])
        puts "[WALLET CHANGE] A block has been found! +#{wallet_last_transaction['amount']}"
        notifier.notify "[#{time_format(time)}] +#{wallet_last_transaction['amount']} - [total: #{wallet_balance}]"
      end
      sleep sleep_time
    end
  end

  def wallet_changed?(old_wallet_state, new_wallet_state)
    change_flag = false

    if old_wallet_state["time"] != new_wallet_state["time"]
      change_flag = true
    end

    @last_transaction = new_wallet_state
    change_flag
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
