require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/mock'
project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/../lib/*') { |file| require file }
