require 'active_support'

module Agap
  module Config
    mattr_accessor :header_link_max_size
    @@header_link_max_size = 15
  end
end