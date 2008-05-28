require "restful_easy_emails_system"
ActiveRecord::Base.send :include, ProtonMicro::RestfulEasyEmails::Emails
