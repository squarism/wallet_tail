require 'dotenv/tasks'

require './lib/monitor'

task :monitor => :dotenv do
  monitor = Monitor.new

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