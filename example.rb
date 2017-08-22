#! /usr/bin/ruby

require 'sinatra'
require 'haml'
require 'json'
require_relative 'lib/torre_backend.rb'
require_relative 'lib/torre_database.rb'

# get over 5 min results
t = 300
gitlab = 'https://about.gitlab.com/'
puts "gathering https reponses over #{t}seconds please wait"
test0 = Torre.new(gitlab, t)
test0.gather_responses
puts test0.res_times
puts 'db results'
# good if you want to do something persistent with db
test0.res_times_todb

# web chart result on http://localhost:4567/
get '/' do
  @res_times = []
  hres = HttpRes.all
  hres.each do |elem|
    @res_times.push(elem.real_time)
  end
  haml :index
end  
