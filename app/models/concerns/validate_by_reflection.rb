# Come back and look into refactoring this / making the methods more "Ruby-like".
module ValidateByReflection
  extend ActiveSupport::Concern

  # For now, have it be opt-in, that is they have to call create_validators in the model.
  # included do
  #   create_validators
  # end

  module ClassMethods
    # this method is tested in the models using shoulda validation matchers
    def create_validators
      build_args_for_validate.each do |args|
        validates(*args)
      end
    end

    def build_args_for_validate
      @@validator_digest = validator_digest

      args_for_each_validation = []
      columns.each do |column|
        next if column.name == primary_key
        args_for_each_validation <<
          length_validation_args(column) <<
          numericality_validation_args(column) <<
          presence_validation_args(column) <<
          uniqueness_validation_args(column)
      end

      return args_for_each_validation.compact
    end

    def length_validation_args(column)
      return nil if foreign_key_columns[column.name] or @@validator_digest[:length].include? column.name.to_sym

      if ( options = column.validate_length_options )
        [column.name.to_sym, length: options ]
      end
    end
    def numericality_validation_args(column)
      return nil if foreign_key_columns[column.name] or @@validator_digest[:numericality].include? column.name.to_sym

      if ( options = column.validate_numericality_options )
        [column.name.to_sym, numericality: options]
      end
    end

    def presence_validation_args(column)
      return nil unless column.validate_presence? or @@validator_digest[:presence].include? column.name.to_sym

      if ( reflection = foreign_key_columns[column.name] ) and ( options = reflection.validate_presence_options )
        [reflection.name.to_sym, presence: options]
      else
        [column.name.to_sym, presence: true]
      end
    end
    def uniqueness_validation_args(column)
      return nil if @@validator_digest[:uniqueness].include? column.name.to_sym

      if ( reflection = foreign_key_columns[column.name] )
        options = reflection.validate_uniqueness_options if index_exists?([reflection.foreign_key, reflection.foreign_type], unique: true)
      elsif index_exists?(column.name.to_sym, unique: true)
        options = true
      end

      return [column.name.to_sym, uniqueness: options] if options
    end
  end
end
