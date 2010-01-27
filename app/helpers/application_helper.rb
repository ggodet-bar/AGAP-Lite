# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
 
  def shortify(a_string)
    if !a_string.blank? && a_string.length > Agap::Config.header_link_max_size
      a_string.slice(0..Agap::Config.header_link_max_size - 1) + '...'
    else
      a_string
    end
  end


  MINIMUM_NAME_LENGTH = 4
  MAXIMUM_NAME_LENGTH = 12

  def generate_short_name(str)
    raise 'Invalid string' if str.strip == '' or str.strip.length < MINIMUM_NAME_LENGTH
    first_pass = str.strip.unpack('U*').select{|cp| cp < 127}.pack('U*')
    first_pass.downcase.slice(0..MAXIMUM_NAME_LENGTH-1).gsub(/\s/, '_')

  end

end
