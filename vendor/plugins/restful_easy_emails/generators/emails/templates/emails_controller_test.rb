require File.dirname(__FILE__) + '/../test_helper'
require 'emails_controller'

# Re-raise errors caught by the controller.
class MessagesController; def rescue_action(e) raise e end; end

class MessagesControllerTest < Test::Unit::TestCase

  include AuthenticatedTestHelper

  fixtures :users, :emails

  def setup
    @controller = MessagesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    login_as("sam")
    get :index, :user_id => users(:sam)
    assert_response :redirect
    assert_redirected_to inbox_profile_emails_path
  end
  
  def test_should_get_inbox
    login_as("sam")
    get :inbox, :user_id => users(:sam)
    assert_response :success
  end
  
  def test_should_get_outbox
    login_as("sam")
    get :outbox, :user_id => users(:sam)
    assert_response :success
  end
  
  def test_should_get_trashbin
    login_as("sam")
    get :inbox, :user_id => users(:sam)
    assert_response :success
  end
  
  def test_should_get_new
    login_as("sam")
    get :new, :user_id => users(:sam)
    assert_response :success
  end
  
  def test_should_route_emails_of_user
    options = { :controller => 'emails',
                :action => 'inbox',
                :user_id => '3' }
    assert_routing('users/3/emails/inbox', options)
  end
  
  def test_should_get_email
    login_as("sam")
    get :show, :user_id => users(:sam), :id => emails(:abby_to_sam_1)
    assert_response :success
  end
  
  def test_should_protect_email
    login_as("sam")
    get :show, :user_id => users(:sam), :id => emails(:abby_to_catie_1)
    assert_response :forbidden
  end
  
  def test_should_create_email
    email_count = Message.count
    login_as("sam")
    post :create, :user_id => users(:sam), :email => {:recipient => 'abby', :subject => "hi", :body => "Abby, how was school today?"}
    assert_response :redirect
    assert_redirected_to outbox_profile_emails_path
    assert_equal email_count + 1, Message.count
  end
  
  def test_should_delete_received_email
    email_pre_delete_state = Message.find(emails(:abby_to_sam_1))
    login_as("sam")
    delete :destroy, :user_id => users(:sam), :id => emails(:abby_to_sam_1)
    assert_response :redirect
    email_post_delete_state = Message.find(emails(:abby_to_sam_1))
    assert_not_equal email_pre_delete_state.receiver_deleted, email_post_delete_state.receiver_deleted
  end
  
  def test_should_delete_sent_email
    email_pre_delete_state = Message.find(emails(:sam_to_abby_1))
    login_as("sam")
    delete :destroy, :user_id => users(:sam), :id => emails(:sam_to_abby_1)
    assert_response :redirect
    email_post_delete_state = Message.find(emails(:sam_to_abby_1))
    assert_not_equal email_pre_delete_state.sender_deleted, email_post_delete_state.sender_deleted
  end

  def test_should_not_delete_email
    email_pre_delete_state = Message.find(emails(:abby_to_sam_1))
    login_as("sam")
    delete :destroy, :user_id => users(:sam), :id => emails(:abby_to_catie_1)
    assert_response :forbidden
    email_post_delete_state = Message.find(emails(:abby_to_sam_1))
    assert_equal email_pre_delete_state.receiver_deleted, email_post_delete_state.receiver_deleted
  end
  
  def test_should_reply_to_email
    login_as("sam")
    get :reply, :user_id => users(:sam), :id => emails(:abby_to_sam_1)
    assert_response :success
  end
  
  def test_should_not_reply_to_email
    login_as("sam")
    get :reply, :user_id => users(:sam), :id => emails(:abby_to_catie_1)
    assert_response :forbidden
  end
end
