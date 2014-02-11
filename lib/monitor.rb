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

  def wallet_difficulty
    wallet.difficulty
  end

  # TODO: we might not need this again for the notification message
  #       it takes up too much room on the iOS notification screen
  def time_format(time)
    time.strftime('%F %r') + " " + time.zone
  end

  def start
    puts "\"I'll tell you when receive coins.\""
    puts "   -- Wallet Tail"

    # initial states
    @running = true
    @last_balance = wallet_balance
    @last_transaction = wallet_last_transaction

    sleep 5  # initial boot sleep time

    while @running do
      if wallet_changed?(@last_transaction, wallet_last_transaction)
        time = Time.at(wallet_last_transaction['time'])

        puts "Wallet Change!  +#{wallet_last_transaction['amount']}"

        notifier.notify(
          "+#{wallet_last_transaction['amount']}\n" +
          "[ total: #{wallet_balance.to_i} ][ difficulty: #{wallet_difficulty.to_i} ]"
        )
      end
      sleep sleep_time
    end
  end

  def wallet_changed?(old_wallet_state, new_wallet_state)
    change_flag = false
    return change_flag if old_wallet_state == nil  # a wallet with no transactions will be nil

    if old_wallet_state["time"] != new_wallet_state["time"]
      change_flag = true
      @last_transaction = new_wallet_state
    end

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
