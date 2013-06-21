require 'test_helper'

class SubOrcamentosControllerTest < ActionController::TestCase
  setup do
    @sub_orcamento = sub_orcamentos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sub_orcamentos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sub_orcamento" do
    assert_difference('SubOrcamento.count') do
      post :create, sub_orcamento: @sub_orcamento.attributes
    end

    assert_redirected_to sub_orcamento_path(assigns(:sub_orcamento))
  end

  test "should show sub_orcamento" do
    get :show, id: @sub_orcamento.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sub_orcamento.to_param
    assert_response :success
  end

  test "should update sub_orcamento" do
    put :update, id: @sub_orcamento.to_param, sub_orcamento: @sub_orcamento.attributes
    assert_redirected_to sub_orcamento_path(assigns(:sub_orcamento))
  end

  test "should destroy sub_orcamento" do
    assert_difference('SubOrcamento.count', -1) do
      delete :destroy, id: @sub_orcamento.to_param
    end

    assert_redirected_to sub_orcamentos_path
  end
end
