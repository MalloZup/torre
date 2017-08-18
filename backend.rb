#! /usr/bin/ruby

require 'net/http'
require 'timeout'
require 'uri'
puts "test2"
# Torre class, get http response over a custom time.
# get HTTP response times over XX sec from your location to website XX
class Torre
  attr_reader :res_times
  def initialize(uri, time)
    @uri = uri
    @to_test_time = time
    @res_times = []
  end

  def res_page
    start_time = Time.now
    response = Net::HTTP.get(URI.parse(@uri))
    end_time = Time.now - start_time
    return false if response == ''
    return end_time
  rescue
    # if the site we test the reponse is down or we have some errors,
    # return false.
    return false
  end

  def gather_responses
    Timeout.timeout(@to_test_time) do
      loop { @res_times.push(res_page) }
    end
  rescue Timeout::Error
    puts "#{@to_test_time} seconds elapsed."
  end

  private :res_page
end

# 300 is 5 min
#
# MAIN
#
t = 4
gitlab = 'https://about.gitlab.com/'
tensec = Torre.new(gitlab, t)
tensec.gather_responses
puts tensec.res_times
