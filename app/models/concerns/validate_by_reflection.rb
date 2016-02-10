# Come back and look into refactoring this / making the methods more "Ruby-like".
module ValidateByReflection
  # this method is tested in the models using shoulda validation matchers
  def generate_validations_for(*column_names)
    build_args_for_validate(column_names).each do |args|
      validates(*args)
    end
  end

  private
  def build_args_for_validate(column_names)
    columns_to_skip =  [primary_key, 'created_at', 'updated_at']

    _column_names = column_names.collect { |column_name| columns_hash[column_name.to_s] }

    args_arrays = []
    _column_names.each do |column|
      next if columns_to_skip.include? column.name
      types_to_skip = validation_types_for(column.name)
      types_to_skip << :uniqueness unless index_exists?(column.name, unique: true)

      if self.has_fk?(column.name)
        association = association_for(column.name)

        if association.polymorphic? and index_exists?([column.name, association.foreign_type], unique: true)
          types_to_skip.delete(:uniqueness)
        end

        args_arrays += association.validation_args(types_to_skip)
      else
        args_arrays += column.validation_args(types_to_skip)
      end
    end

    return args_arrays.compact
  end
end
