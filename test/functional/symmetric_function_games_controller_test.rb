require 'test_helper'

class SymmetricFunctionGamesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:symmetric_function_games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create symmetric_function_game" do
    assert_difference('SymmetricFunctionGame.count') do
      post :create, :symmetric_function_game => { }
    end

    assert_redirected_to symmetric_function_game_path(assigns(:symmetric_function_game))
  end

  test "should show symmetric_function_game" do
    get :show, :id => symmetric_function_games(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => symmetric_function_games(:one).to_param
    assert_response :success
  end

  test "should update symmetric_function_game" do
    put :update, :id => symmetric_function_games(:one).to_param, :symmetric_function_game => { }
    assert_redirected_to symmetric_function_game_path(assigns(:symmetric_function_game))
  end

  test "should destroy symmetric_function_game" do
    assert_difference('SymmetricFunctionGame.count', -1) do
      delete :destroy, :id => symmetric_function_games(:one).to_param
    end

    assert_redirected_to symmetric_function_games_path
  end
end
