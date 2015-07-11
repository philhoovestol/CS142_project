require 'test_helper'

class TaggerControllerTest < ActionController::TestCase
  test "should get tag" do
    get :tag
    assert_response :success
  end

end
