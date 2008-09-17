module ProfileHelper
  def inbox_count
    current_user.unread_emails.count
  end
  def user_name(thing)
    @named = User.find(thing)
    return @named.login
  end
end
