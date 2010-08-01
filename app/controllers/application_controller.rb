# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  uses_tiny_mce

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '59133f99ad2fd376b01c658aaae40434'
  
  MINIMUM_NAME_LENGTH = 4
  MAXIMUM_NAME_LENGTH = 12

  def generate_short_name(str)
    raise 'Invalid string' if str.strip == '' or str.strip.length < MINIMUM_NAME_LENGTH
    first_pass = str.strip.unpack('U*').select{|cp| cp < 127}.pack('U*')
    first_pass.downcase.slice(0..MAXIMUM_NAME_LENGTH-1).gsub(/\s/, '_')
  end

end
