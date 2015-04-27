#!/usr/bin/ruby
require 'uri'

# config
require './config'


data = []
File.open(ARGV[0], 'r') do |io|
  line = io.gets
  while line
    data << line.chomp!
  end
end

# Capture screen
userinfo = OPEN_URI_OPTIONS[:http_basic_authentication]
data.each do |a|
  uri = URI(a)
  uri.userinfo = userinfo.join(':')
  s = uri.host + uri.path
  puts filename = s.gsub(/\.|\//, '-').gsub(/-$/, '')
  system "webkit2png --fullsize --width 1280 --dir output --filename=#{filename} --delay=3 #{uri}"
end
