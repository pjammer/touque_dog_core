require File.dirname(__FILE__) + '/../test_helper'

class AskingsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:askings)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_asking
    assert_difference('Asking.count') do
      post :create, :asking => { }
    end

    assert_redirected_to asking_path(assigns(:asking))
  end

  def test_should_show_asking
    get :show, :id => askings(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => askings(:one).id
    assert_response :success
  end

  def test_should_update_asking
    put :update, :id => askings(:one).id, :asking => { }
    assert_redirected_to asking_path(assigns(:asking))
  end

  def test_should_destroy_asking
    assert_difference('Asking.count', -1) do
      delete :destroy, :id => askings(:one).id
    end

    assert_redirected_to askings_path
  end
end
