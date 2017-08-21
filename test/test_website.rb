require_relative 'helper'
require 'webrick'
require 'fileutils'

# this class test the simply case that we have a website up and running
# and a test if we have a down website.
class WebSiteTests < Minitest::Test
  def test_siteonline
    assert_equal(true, true)
  end

  def start_webrick
    root = File.expand_path Dir.pwd
    server = WEBrick::HTTPServer.new Port: 9988, DocumentRoot: root
    trap 'INT' do
      server.shutdown
    end
    fork { server.start }
  end

  def db_check_site(ck)
    hres = HttpRes.all
    hres.each do |elem|
      assert(elem.site_up == ck)
    end
    FileUtils.rm(Dir.pwd + 'torre.db')
  end

  def test_online_site
    rick_pid = start_webrick
    # gather res times
    sec = 3
    test = Torre.new('http://localhost:9988', sec)
    test.gather_responses
    # since the website is up, all resp are numeric
    test.res_times.each do |resp|
      assert((resp.is_a? Numeric))
    end
    Process.kill('INT', rick_pid)
    test.res_times_todb
    db_check_site(true)
  end

  def test_downtime
    test2 = Torre.new('http://localhost:9988', 3)
    test2.gather_responses
    # since the website is up, all resp are numeric
    test2.res_times.each do |resp|
      assert(resp == false)
    end
  end
end
