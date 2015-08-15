require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full_title test" do
    assert_equal full_title,         "Consumer of Pitiful Trinkets"
    assert_equal full_title("Meow"), "Meow | Consumer of Pitiful Trinkets"
  end
end