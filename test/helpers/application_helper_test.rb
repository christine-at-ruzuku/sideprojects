require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title, "The Quiz Maker App"
    assert_equal full_title("Help"), "Help | The Quiz Maker App"
  end
end