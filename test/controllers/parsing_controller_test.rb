require 'test_helper'

class ParsingControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
