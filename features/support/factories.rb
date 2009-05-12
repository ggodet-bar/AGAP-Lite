Factory.define :process_pattern do |pat|
  pat.sequence(:name) { |n| "pattern name #{n}" }
  pat.author  "Bob le poulpe"
  pat.association :pattern_system
  pat.association :mappable_image
end

Factory.define :pattern_system do |sys|
  sys.sequence(:short_name) { |n| "sys_#{n}"}
  sys.sequence(:name) {|n| "pattern system name #{n}"}
  sys.author "Bob le poulpe"
  # sys.process_patterns  {|a| a.association(:process_pattern)}
end

Factory.define :mappable_image do |image|
  image.association :pattern_system
  image.filename  "CycleSymphAugmente.png"
  image.width 800
  image.height  954
  image.size  201146
  image.content_type  "image/png"
end

Factory.define :participant do |participant|
  participant.sequence(:name) { |n|  "participant name #{n}"}
  participant.description "Any description"
  participant.association :pattern_system
  
end