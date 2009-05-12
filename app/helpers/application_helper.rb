# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def shortify(a_string)
    if !a_string.blank? && a_string.length > Agap::Config.header_link_max_size
      a_string = a_string.slice!(0..Agap::Config.header_link_max_size - 1) + '...'
    else
      a_string
    end
  end
end
