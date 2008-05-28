require File.dirname(__FILE__) + '/../test_helper'

class MessageTest < Test::Unit::TestCase

  fixtures :users, :emails

  def test_should_mark_email_read
    m = emails(:abby_to_sam_1)
    assert_nil m.read_at
    m.mark_email_read(users(:sam))
    assert_not_nil m.read_at
  end

  def test_should_purge_email
    m = emails(:abby_to_sam_Trash_2)
    n = m.id
    assert_not_nil m
    m.purge
    m = Message.find_by_id(n)
    assert_nil m
  end

  def test_should_require_body
    assert_no_difference Message, :count do
      m = create_email(:body => nil)
      assert m.errors.on(:body)
    end
  end

  def test_should_require_recipient
    assert_no_difference Message, :count do
      m = create_email(:recipient => nil)
      assert m.errors.on(:recipient)
    end
  end
  
  def test_should_require_subject
    assert_no_difference Message, :count do
      m = create_email(:subject => nil)
      assert m.errors.on(:subject)
    end
  end
  
  def test_should_return_sender_name
    m = create_email
    assert_not_nil m.sender_name
  end
  
  def test_should_return_receiver_name
    m = create_email
    m.receiver = users(:sam)
    assert_not_nil m.receiver_name
  end
  
  
  protected
  
  def assert_difference(object, method = nil, difference = 1)
    initial_value = object.send(method)
    yield
    assert_equal initial_value + difference, object.send(method), "#{object}##{method}"
  end

  def assert_no_difference(object, method, &block)
    assert_difference object, method, 0, &block
  end
  
  def create_email(options = {})
    Message.create({ :recipient => users(:sam), :sender => users(:abby), :subject => 'new email', :body => 'new email body is really short' }.merge(options))
  end
end
