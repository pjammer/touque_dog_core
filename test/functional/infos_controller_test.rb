require File.dirname(__FILE__) + '/../test_helper'

class InfosControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:infos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_info
    assert_difference('Info.count') do
      post :create, :info => { }
    end

    assert_redirected_to info_path(assigns(:info))
  end

  def test_should_show_info
    get :show, :id => infos(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => infos(:one).id
    assert_response :success
  end

  def test_should_update_info
    put :update, :id => infos(:one).id, :info => { }
    assert_redirected_to info_path(assigns(:info))
  end

  def test_should_destroy_info
    assert_difference('Info.count', -1) do
      delete :destroy, :id => infos(:one).id
    end

    assert_redirected_to infos_path
  end
end
