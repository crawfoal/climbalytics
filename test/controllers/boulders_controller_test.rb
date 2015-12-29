require 'test_helper'

class BouldersControllerTest < ActionController::TestCase
  setup do
    @boulder = boulders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:boulders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create boulder" do
    assert_difference('Boulder.count') do
      post :create, boulder: { grade: @boulder.grade, name: @boulder.name, picture: @boulder.picture }
    end

    assert_redirected_to boulder_path(assigns(:boulder))
  end

  test "should show boulder" do
    get :show, id: @boulder
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @boulder
    assert_response :success
  end

  test "should update boulder" do
    patch :update, id: @boulder, boulder: { grade: @boulder.grade, name: @boulder.name, picture: @boulder.picture }
    assert_redirected_to boulder_path(assigns(:boulder))
  end

  test "should destroy boulder" do
    assert_difference('Boulder.count', -1) do
      delete :destroy, id: @boulder
    end

    assert_redirected_to boulders_path
  end
end
