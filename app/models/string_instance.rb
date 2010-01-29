class StringInstance < ActiveRecord::Base
  belongs_to :pattern
  belongs_to :field_descriptor
end
