atom_feed do |feed|
  feed.title "#{@rezm_user.login.capitalize}'s Inbox"
  feed.updated @emails.first.created_at
  
  for email in @emails
    feed.entry(email, :url => user_email_url(rezm_user, email)) do |entry|
     entry.title   email.subject
      entry.content email.body, :type => 'html'
      
      entry.author do |author|
        author.name email.sender.login
      end
    end
  end
end