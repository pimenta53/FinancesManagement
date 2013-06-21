require 'test_helper'

class PatrociniosControllerTest < ActionController::TestCase
  setup do
    @patrocinio = patrocinios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:patrocinios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create patrocinio" do
    assert_difference('Patrocinio.count') do
      post :create, patrocinio: @patrocinio.attributes
    end

    assert_redirected_to patrocinio_path(assigns(:patrocinio))
  end

  test "should show patrocinio" do
    get :show, id: @patrocinio.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @patrocinio.to_param
    assert_response :success
  end

  test "should update patrocinio" do
    put :update, id: @patrocinio.to_param, patrocinio: @patrocinio.attributes
    assert_redirected_to patrocinio_path(assigns(:patrocinio))
  end

  test "should destroy patrocinio" do
    assert_difference('Patrocinio.count', -1) do
      delete :destroy, id: @patrocinio.to_param
    end

    assert_redirected_to patrocinios_path
  end
end
