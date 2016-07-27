#!/usr/bin/env ruby
begin
    require 'rubygems'
    # you should compile the ruby binary with readline-dev
    begin
        require 'wirble' # gem
        IRB.conf[:USE_READLINE] = true
        IRB.conf[:SAVE_HISTORY] = 100000
        IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
        Wirble.init
        Wirble.colorize
    rescue LoadError
        require 'irb/completion'
        require 'irb/history'
        require 'irb/ext/save-history'
        IRB::History.start_client
        IRB.conf[:USE_READLINE] = true
        IRB.conf[:SAVE_HISTORY] = 100000
        IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
    end
rescue => e
    p e
end
