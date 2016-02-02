module Randomable

  extend ActiveSupport::Concern

  module ClassMethods
    def random(total_count = nil)
      offset( rand( total_count || count ) ).first
    end
  end

end
