require 'test_helper'

class ClubAdminsControllerTest < ActionController::TestCase
  setup do
    @club_admin = club_admins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:club_admins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create club_admin" do
    assert_difference('ClubAdmin.count') do
      post :create, club_admin: {  }
    end

    assert_redirected_to club_admin_path(assigns(:club_admin))
  end

  test "should show club_admin" do
    get :show, id: @club_admin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @club_admin
    assert_response :success
  end

  test "should update club_admin" do
    patch :update, id: @club_admin, club_admin: {  }
    assert_redirected_to club_admin_path(assigns(:club_admin))
  end

  test "should destroy club_admin" do
    assert_difference('ClubAdmin.count', -1) do
      delete :destroy, id: @club_admin
    end

    assert_redirected_to club_admins_path
  end
end
