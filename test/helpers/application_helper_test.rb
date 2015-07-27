require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full_title test" do
    assert_equal full_title,         "Spider With 1000 Eyes"
    assert_equal full_title("Meow"), "Meow | Spider With 1000 Eyes"
  end
end