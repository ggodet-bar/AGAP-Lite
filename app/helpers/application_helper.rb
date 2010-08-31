# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
 
  CONTROLLER_TAB_ASSOCIATION = {
    'pattern_systems' => %w(pattern_systems patterns),
    'system_formalisms' => %w(system_formalisms pattern_formalisms)
  }

  def associated_controllers(tab_name)
    CONTROLLER_TAB_ASSOCIATION[tab_name]
  end

  def shortify(a_string)
    if !a_string.blank? && a_string.length > Agap::Config.header_link_max_size
      a_string.slice(0..Agap::Config.header_link_max_size - 1) + '...'
    else
      a_string
    end
  end

  def human_name(controller_name)
    controller_name.gsub(/_/, ' ').capitalize
  end

end
