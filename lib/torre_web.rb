#! /usr/bin/ruby

require 'sinatra'
require 'haml'

get '/' do
  @test0 = 'Welcome to torre'
  haml :index
end
