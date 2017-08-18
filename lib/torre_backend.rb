#! /usr/bin/ruby

require 'net/http'
require 'timeout'
require 'uri'
require_relative 'torre_database'

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

  # database specific method
  def res_times_todb
    TorreDB.new('sqlite3', 'torre.db')
    @res_times.each do |value|
      HttpRes.create(real_time: value, site_up: true) unless value == false
      HttpRes.create(real_time: 0, site_up: false) if value == false
    end
    p HttpRes.all
  end
  private :res_page
end
