module ValidationInspector

  # These methods only inspect the column to determine if the property should be validated and what the validation options should be. The column doesn't know anything about the model's associations or indices, so the caller of these functions needs to check those things.
  module Column
    def validate_length_args
      options = if limit
        { maximum: limit }
      elsif type == :string
        { maximum: 255 }
      elsif type == :text
        { maximum: 20000 } # this should be configurable
      end
      [name.to_sym, length: options] if options
    end

    def validate_numericality_args
      options = if type == :integer
        { only_integer: true }
      elsif [:decimal, :float].include? type
        true
      end

      if options
        if null == false
          [name.to_sym, numericality: options]
        else
          [name.to_sym, numericality: options, allow_nil: true]
        end
      else
        return nil
      end
    end

    def validate_presence_args
      [name.to_sym, presence: true] if null == false
    end

    # Doesn't check if the index exists - that needs to be done in the model, so the caller should do it.
    def validate_uniqueness_args
      [name.to_sym, uniqueness: true]
    end

    def validation_args(types_to_skip = [])
      [(validate_length_args unless types_to_skip.include? :length),
      (validate_numericality_args unless types_to_skip.include? :numericality),
      (validate_presence_args unless types_to_skip.include? :presence),
      (validate_uniqueness_args unless types_to_skip.include? :uniqueness)].compact
    end
  end

  # These methods only inspect the association to determine if the property should be validated and what the validation options should be. The column doesn't know anything about the model's database constraints or indices, so the caller of these functions needs to check those things.
  module AssociationReflection
    # :inverse_of only needs to be specified if the inverse can't automatically be determined, so instead just check and see if the inverse can be found. See http://wangjohn.github.io/activerecord/rails/associations/2013/08/14/automatic-inverse-of.html
    def validate_presence_args
      [name.to_sym, presence: true] if inverse_of
    end

    def validate_uniqueness_args
      options = if polymorphic?
        { scope: foreign_type.to_sym }
      else
        true
      end
      [foreign_key.to_sym, uniqueness: options]
    end

    def validation_args(types_to_skip = [])
      [(validate_presence_args unless types_to_skip.include? :presence),
      (validate_uniqueness_args unless types_to_skip.include? :uniqueness)].compact
    end
  end

end
