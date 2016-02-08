module ValidatorInspector
  def validation_types_for(column_name)
    validators_for(column_name).collect do |validator|
      validator.kind
    end
  end
  def validators_for(column_name)
    _column_name = column_name.to_sym
    validators.each.select do |validator|
      validator.attributes.include? _column_name
    end
  end
end
