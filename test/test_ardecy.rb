require 'minitest/autorun'
require 'ardecy'

class TestArdecy < Minitest::Test
  def test_version
    assert_equal '0.0.1', Ardecy::VERSION
  end
end

