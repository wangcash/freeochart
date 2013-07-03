require 'test_helper'

class OchartsControllerTest < ActionController::TestCase
  setup do
    @ochart = ocharts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ocharts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ochart" do
    assert_difference('Ochart.count') do
      post :create, ochart: { comp_id: @ochart.comp_id, department_name: @ochart.department_name, ochart_id: @ochart.ochart_id, parent_id: @ochart.parent_id }
    end

    assert_redirected_to ochart_path(assigns(:ochart))
  end

  test "should show ochart" do
    get :show, id: @ochart
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ochart
    assert_response :success
  end

  test "should update ochart" do
    patch :update, id: @ochart, ochart: { comp_id: @ochart.comp_id, department_name: @ochart.department_name, ochart_id: @ochart.ochart_id, parent_id: @ochart.parent_id }
    assert_redirected_to ochart_path(assigns(:ochart))
  end

  test "should destroy ochart" do
    assert_difference('Ochart.count', -1) do
      delete :destroy, id: @ochart
    end

    assert_redirected_to ocharts_path
  end
end
