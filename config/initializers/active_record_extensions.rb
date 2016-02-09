class ActiveRecord::Base
  # Concerns
  include Randomable
  include IndexInspector

  # Regular Modules
  extend KeyInspector
  extend ValidatorInspector
  extend ValidateByReflection
end

class ActiveRecord::ConnectionAdapters::Column
  include ValidationInspector::Column
end

class ActiveRecord::Reflection::AssociationReflection
  include ValidationInspector::AssociationReflection
end
