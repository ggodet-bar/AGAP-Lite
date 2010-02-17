Factory.define :system_formalism do |sys|
  sys.sequence(:name) {|n| "A #{n}th system formalism"}
  sys.author "Bob le poulpe"
  sys.version "0.0.1"
end

Factory.define :pattern_formalism do |pat|
  pat.sequence(:name) {|n| "#{n}th pattern formalism"}
  pat.association :system_formalism
  #pat.association :field_descriptors, :factory => :field_descriptor
end

Factory.define :field_descriptor do |field|
  field.association :pattern_formalism
  field.name "A sample field name"
  field.description "A sample field description"
  field.section "interface"
end

Factory.define :pattern_system do |sys|
  sys.sequence(:name) {|n| "#{n}th pattern system name"}
  sys.author "Bob le poulpe"
  sys.short_name {|a| a.name.gsub(/\s/,"_").slice(0..8)}
  sys.association :system_formalism
  # sys.process_patterns  {|a| a.association(:process_pattern)}
end

Factory.define :classification_element do |classif|
  classif.sequence(:name) {|n| "#{n}th classification element"}
  classif.description "Some fake description"
  classif.association :pattern_system
  classif.association :field_descriptor
end

Factory.define :pattern do |pat|
  pat.sequence(:name) {|n| "#{n}th pattern name"}
  pat.association :pattern_formalism
  pat.association :pattern_system
end

Factory.define :mappable_image do |image|
  image.association :pattern_system
end

Factory.define :image_association do |assoc|
  assoc.association :field_descriptor
end

Factory.define :relation do |relation|
  relation.name "fake_relation"
end
