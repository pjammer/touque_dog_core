class EmailsGenerator < Rails::Generator::NamedBase
 
  def initialize(args, options = {})
    super
    # do any needed initializations here
  end
 
  def manifest
    record do |m|
      # Controller
      m.file "emails_controller.rb", "app/controllers/emails_controller.rb" 
      
      # Helper
      m.file "emails_helper.rb", "app/helpers/emails_helper.rb"
      
      # Model
      m.file "email.rb", "app/models/email.rb"
            
      # Views
      m.directory "app/views/emails"
      m.file "index.atom.builder", "app/views/emails/index.atom.builder"
      
      if file_name == "haml"
        m.file "index.haml", "app/views/emails/index.haml"
        m.file "new.haml",   "app/views/emails/new.haml"
        m.file "show.haml",  "app/views/emails/show.haml"
      else
        m.file "index.html.erb",     "app/views/emails/index.html.erb"
        m.file "new.html.erb",       "app/views/emails/new.html.erb"
        m.file "show.html.erb",      "app/views/emails/show.html.erb" 
      end
      
      # Lib
      m.file "restful_easy_emails_controller_system.rb", "lib/restful_easy_emails_controller_system.rb"
      
      # Public
      m.file "403.html", "public/403.html"
      
      # Tests
      m.file "emails.yml",                "test/fixtures/emails.yml"
      m.file "users.yml",                   "test/fixtures/users.yml"
      m.file "emails_controller_test.rb", "test/functional/emails_controller_test.rb"
      m.file "email_test.rb",             "test/unit/email_test.rb"   
      
      # Migration
      m.migration_template 'create_restful_easy_emails.rb', 'db/migrate', :assigns => {
        :migration_name => "CreateRestfulEasyMessages"
      }, :migration_file_name => "create_restful_easy_emails"
      
    end
  end 
 
end