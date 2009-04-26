Factory.define :process_pattern do |pat|
  pat.sequence(:name) { |n| "pattern name #{n}" }
  pat.author  "Bob le poulpe"
  pat.association :pattern_system
end

Factory.define :pattern_system do |sys|
  sys.sequence(:short_name) { |n| "sys_#{n}"}
  sys.sequence(:name) {|n| "pattern system name #{n}"}
  sys.author "Bob le poulpe"
  # sys.process_patterns  {|a| a.association(:process_pattern)}
end