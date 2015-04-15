#!/usr/bin/ruby
require 'uri'
require 'open-uri'
require 'openssl'
require 'nokogiri'
require 'readline'
require 'optparse'
require './lib/capture_module'


# config
require './config'


# Parse CLI args
OPTS = {}
opt = OptionParser.new
opt.on('-i', '--internal-link') { |v| OPTS[:i] = v }
opt.parse!(ARGV)


data = []
File.open(ARGV[0], 'r') do |io|
  while line = io.gets
    data << line.chomp!
  end
end


# Create anchor list
anchors = []
data.each do |uri|
  html = CaptureModule.get_html(uri, OPEN_URI_OPTIONS).to_s.encode('utf-8', CHARSET)
  doc = Nokogiri::HTML.parse(html)
  anchors << CaptureModule.get_anchors(doc, uri, BASE_URI)
  anchors << uri
end
anchors.flatten!.uniq!

targets = []
if OPTS[:i]
  anchors.each do |a|
    targets << a if a =~ /#{BASE_URI}/
  end
else
  targets = anchors
end


# Save file
File.open(OUTPUT, 'w+:utf-8') do |f|
  f.puts(targets.sort!)
end
puts "Target size: #{targets.size}"
