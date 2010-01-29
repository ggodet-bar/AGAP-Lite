# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '59133f99ad2fd376b01c658aaae40434'
  
  uses_tiny_mce :options  =>  {  
                                :encoding => 'html',
                                :theme  => 'advanced',
                                :plugins => %w{ upimage safari },
                                :theme_advanced_buttons1_add  => 'upimage'
                              },
		:only => [:new, :create, :edit, :update]
  I18n.locale = :fr
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  MINIMUM_NAME_LENGTH = 4
  MAXIMUM_NAME_LENGTH = 12

  def generate_short_name(str)
    raise 'Invalid string' if str.strip == '' or str.strip.length < MINIMUM_NAME_LENGTH
    first_pass = str.strip.unpack('U*').select{|cp| cp < 127}.pack('U*')
    first_pass.downcase.slice(0..MAXIMUM_NAME_LENGTH-1).gsub(/\s/, '_')

  end
end
