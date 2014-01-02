require 'dotenv'
require 'dotenv/tasks'
require './lib/monitor'


task :monitor => :dotenv do
  # black magic for making rake do sane command line options
  # http://itshouldbeuseful.wordpress.com/2011/11/07/passing-parameters-to-a-rake-task/
  config = ARGV.last
  task config.to_sym do ; end
  if config == "monitor"
    config = nil
  end


  monitor = Monitor.new
  monitor.load_profile(config)

  begin
    monitor.start
  rescue SystemExit, Interrupt
    puts "Imma stoppin."
    monitor.stop
  end

  trap "TERM" do
    monitor.stop
  end

  puts "Done."
end