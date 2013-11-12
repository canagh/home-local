#!/usr/bin/env ruby
require 'rubygems'

# to use history permanently
require 'irb/history'
IRB::History.start_client
IRB.conf[:SAVE_HISTORY] = 100000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/var/history/irb"

require "irb/completion"
