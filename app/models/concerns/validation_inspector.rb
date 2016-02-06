module ValidationInspector

  # These methods only inspect the column to determine if the property should be validated and what the validation options should be. The column doesn't know anything about the model's associations or indices, so the caller of these functions needs to check those things.
  module Column
    def validate_length_options
      if limit
        { maximum: limit }
      elsif type == :string
        { maximum: 255 }
      elsif type == :text
        { maximum: 20000 } # this should be configurable
      elsif type == :integer
        { maximum: 11 }
      end
    end

    def validate_numericality_options
      if type == :integer
        { only_integer: true }
      elsif [:decimal, :float].include? type
        true
      end
    end

    # :inverse_of only needs to be specified if the inverse can't automatically be determined, so instead just check and see if the inverse can be found. See http://wangjohn.github.io/activerecord/rails/associations/2013/08/14/automatic-inverse-of.html
    def validate_presence_options
      true if null == false
    end
    alias_method :validate_presence?, :validate_presence_options
  end

  # These methods only inspect the association to determine if the property should be validated and what the validation options should be. The column doesn't know anything about the model's database constraints or indices, so the caller of these functions needs to check those things.
  module AssociationReflection
    def validate_presence_options
      name if inverse_of
    end

    def validate_uniqueness_options
      if polymorphic?
        { scope: foreign_type.to_sym }
      else
        true
      end
    end
  end

end
