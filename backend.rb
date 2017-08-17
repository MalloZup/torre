#! /usr/bin/ruby

require 'benchmark'
require 'net/http'
require 'timeout'

# Torre class, get http response over a custom time.
# get HTTP response times over XX sec from your location to website XX
class Torre
  attr_reader :res_times
  def initialize(uri, time)
    @uri = uri
    @to_test_time = time
    @res_times = []
  end

  def http_res
    Net::HTTP.get_response(URI(@uri))
  end

  def benchmark_http
    realtime = Benchmark.realtime do
      http_res
    end
    @res_times.push(realtime)
  end

  def gather_responses
    Timeout.timeout(@to_test_time) do
      loop do
        benchmark_http
      end
    end
  rescue Timeout::Error
    puts "#{@to_test_time} seconds elapsed."
  end

  private :http_res, :benchmark_http
end

# 300 is 5 min
#
# MAIN
#
t = 4
gitlab = 'https://aboutf.gitlab.com/'
tensec = Torre.new(gitlab, t)
tensec.gather_responses
puts tensec.res_times
