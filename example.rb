#! /usr/bin/ruby

require 'net/http'
require 'timeout'
require 'uri'
require_relative 'lib/torre_backend.rb'

# MAIN example
#

t = 5
gitlab = 'https://about.gitlab.com/'
test0 = Torre.new(gitlab, t)
test0.gather_responses
puts test0.res_times
test0.res_times_todb
