# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  filter_parameter_logging :password
  
  def subdomain
    (self.request.subdomains[0])
  end
  
  private
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "dw" && password == "2010"
    end
  end
  
end
