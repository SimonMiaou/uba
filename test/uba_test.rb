require 'test_helper'

class UbaTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Uba::VERSION
  end
end
