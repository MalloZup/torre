require 'minitest/autorun'
require 'minitest/reporters'
project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/../lib/*.rb') { |f| require f }
