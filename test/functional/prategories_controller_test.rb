require File.dirname(__FILE__) + '/../test_helper'

class PrategoriesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:prategories)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_prategory
    assert_difference('Prategory.count') do
      post :create, :prategory => { }
    end

    assert_redirected_to prategory_path(assigns(:prategory))
  end

  def test_should_show_prategory
    get :show, :id => prategories(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => prategories(:one).id
    assert_response :success
  end

  def test_should_update_prategory
    put :update, :id => prategories(:one).id, :prategory => { }
    assert_redirected_to prategory_path(assigns(:prategory))
  end

  def test_should_destroy_prategory
    assert_difference('Prategory.count', -1) do
      delete :destroy, :id => prategories(:one).id
    end

    assert_redirected_to prategories_path
  end
end
