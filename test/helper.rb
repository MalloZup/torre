require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/mock'
Minitest::Reporters.use!(
  Minitest::Reporters::ProgressReporter.new,
  ENV,
  Minitest.backtrace_filter
)
