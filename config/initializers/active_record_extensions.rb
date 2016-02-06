class ActiveRecord::Base
  # Concerns
  include Randomable
  include IndexInspector
  include ValidateByReflection

  # Regular Modules
  extend KeyInspector
  extend ValidatorInspector
end

class ActiveRecord::ConnectionAdapters::Column
  include ValidationInspector::Column
end

class ActiveRecord::Reflection::AssociationReflection
  include ValidationInspector::AssociationReflection
end
