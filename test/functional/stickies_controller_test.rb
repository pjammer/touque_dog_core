require File.dirname(__FILE__) + '/../test_helper'

class StickiesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:stickies)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_stickie
    assert_difference('Stickie.count') do
      post :create, :stickie => { }
    end

    assert_redirected_to stickie_path(assigns(:stickie))
  end

  def test_should_show_stickie
    get :show, :id => stickies(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => stickies(:one).id
    assert_response :success
  end

  def test_should_update_stickie
    put :update, :id => stickies(:one).id, :stickie => { }
    assert_redirected_to stickie_path(assigns(:stickie))
  end

  def test_should_destroy_stickie
    assert_difference('Stickie.count', -1) do
      delete :destroy, :id => stickies(:one).id
    end

    assert_redirected_to stickies_path
  end
end
