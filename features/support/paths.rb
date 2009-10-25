module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the homepage/
      '/'
    
    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))
    when /the edit page of the pattern with name "([^\"]*)" from pattern system "([^\"]*)"/
      sys_pat = PatternSystem.find_by_short_name($2)
      pat = sys_pat.process_patterns.select{ |pattern|  pattern.name == $1}.first
      edit_pattern_system_process_pattern_path(sys_pat.short_name, pat)
  
    when /the show page of the pattern with name "([^\"]*)" from pattern system "([^\"]*)"/
      sys_pat = PatternSystem.find_by_short_name($2)
      pat = sys_pat.process_patterns.select{ |pattern|  pattern.name == $1}.first
      pattern_system_process_pattern_path(sys_pat.short_name, pat)
      
    when /the page of the pattern system "([^\"]*)"/
      sys_pat = PatternSystem.find_by_name($1)
      pattern_system_path(sys_pat)
      
      
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
