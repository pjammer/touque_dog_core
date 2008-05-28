# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time
  helper_method :current_user, :logged_in?, :is_online?, :admin?, :can_edit?, :rating

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '152798e224e168cae5de803e860f2d75'
  around_filter :set_timezone
  # Return true if a parameter corresponding to the given symbol was posted.
  def param_posted?(sym)
    request.post? and params[sym]
  end
  $PARENTCOMPANY = "PARENT COMPANY NAME HERE"
  $SITE_NAME = "Your Website name here"
  $TAG_LINE = "your tagline here!"
  $PICTURE_NAME = "Avatar"
  $PRIVACY_EMAIL = "privacy at yourwebsite dot com"
  protected
  def authenticate
    authenticate_or_request_with_http_basic do |name, pass|
      name == 'admin' && pass == 'admin'
    end
  end
  def set_timezone
    TzTime.zone =  logged_in? ? current_user.tz :  TZInfo::Timezone.get('America/New_York')
    yield
    TzTime.reset!
  end
end
