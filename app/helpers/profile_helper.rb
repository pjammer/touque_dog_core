module ProfileHelper
  def inbox_count
    current_user.unread_emails.count
  end
end
