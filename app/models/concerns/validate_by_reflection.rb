# Come back and look into refactoring this / making the methods more "Ruby-like".
module ValidateByReflection
  extend ActiveSupport::Concern

  # For now, have it be opt-in, that is they have to call create_validators in the model.
  # included do
  #   create_validators
  # end

  module ClassMethods
    # this method is tested in the models using shoulda validation matchers
    def create_validators(options = {})
      build_args_for_validate(options).each do |args|
        validates(*args)
      end
    end

    def build_args_for_validate(options = {})
      columns_to_skip = Array(options[:skip]).collect(&:to_s) << primary_key << 'created_at' << 'updated_at'

      if options[:only]
        _columns = options[:only].collect { |column_name| columns_hash[column_name.to_s] }
      end

      args_arrays = []
      (_columns || columns).each do |column|
        next if columns_to_skip.include? column.name
        types_to_skip = validation_types_for(column.name)
        types_to_skip << :uniqueness unless index_exists?(column.name, unique: true)

        if has_fk?(column.name)
          args_arrays += get_reflection_via_fk(column.name).validation_args(types_to_skip)
        else
          args_arrays += column.validation_args(types_to_skip)
        end
      end

      return args_arrays.compact
    end
  end
end
