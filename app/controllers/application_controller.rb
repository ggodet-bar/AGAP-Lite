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
                              }
  I18n.locale = :fr
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  # TODO  Passer cette fonction dans un fichier javascript > Permettra de ne pas perdre les paramètres de la page
  # ainsi que d'économiser une requête sur le serveur !
  def display_parameters
    respond_to do |format|
        format.js {
          render :update do |page|       
            page.visual_effect :appear, 'params'
            page.replace_html 'params', :partial => 'shared/parameters'
            page << "if (Cookie.get('noob_mode') == null) {
                        Cookie.set('noob_mode', 'true') ;
            }"
            page << "if (Cookie.get('noob_mode') == 'true') {"
              page['params_caution_text'].replace_html :text => t(:disable_helpers)
              page << "$('param_front_button').setStyle({left: '52px'});"
              page.drop_receiving "off_position", :onDrop =>  "function(draggable){
                $('param_front_button').setStyle({left: '186px'}) ;
                Effect.Fade('params') ;
                Droppables.remove('off_position') ;
                Cookie.set('noob_mode', 'false') ;
                for (var i = 0, element ; element = $$('.helper_info')[i]; i++) {
                  element.setStyle({display: 'none'}) ;
                }
                for (var i = 0, element ; element = $$('.question_mark')[i]; i++) {
                  element.setStyle({display: 'none'}) ;
                }
                }"
            page << "} else { "
              page['params_caution_text'].replace_html :text => t(:enable_helpers)
              page << "$('param_front_button').setStyle({left: '186px'});"
              page.drop_receiving "on_position", :onDrop => "function(draggable){
                $('param_front_button').setStyle({left: '52px'}) ;
                Effect.Fade('params') ;
                Droppables.remove('on_position') ;
                Cookie.set('noob_mode', 'true') ;
                for (var i = 0, element ; element = $$('.question_mark')[i]; i++) {
                  element.setStyle({display: 'inline'}) ;
                }
                }"
            page << "}"
            page << "new Draggable('param_front_button', { constraint: 'horizontal', revert: 'failure', snap: function(x, y, draggable_object) {
              if (x > 186) {
                  return [186, y] ;
              }
              if (x < 52) {
                return [52, y] ;
              }
                return [x, y] ;
              }
            }
            )"
          end
        }
    end
  end

end
