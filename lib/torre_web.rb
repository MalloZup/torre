#! /usr/bin/ruby

require 'sinatra'
require 'haml'

get '/' do
  'Welcome to torre'
  @test0 = "fo"
  @test1 = "fobarreo"
  haml: :test0, :test1
end
