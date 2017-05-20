require 'test_helper'

class LkControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get lk_show_url
    assert_response :success
  end

end
