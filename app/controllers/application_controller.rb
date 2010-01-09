# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '59133f99ad2fd376b01c658aaae40434'
  
  uses_tiny_mce :options  =>  {  
                                :width => 640,
                                :height => 400,
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

end
