# Try to think of a better name for these methods...
module KeyInspector

  def has_fk?(column_name)
    get_reflection_via_fk(column_name) ? true : false
  end

  def get_reflection_via_fk(column_name)
    _column_name = column_name.to_s
    return nil unless column_names.include? _column_name
    reflections.values.find { |reflection| reflection.foreign_key == _column_name }
  end

end
