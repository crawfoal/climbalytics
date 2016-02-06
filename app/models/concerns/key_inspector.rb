# Try to think of a better name for these methods...
module KeyInspector
  def foreign_key_columns
    fk_to_association_hash.select { |foreign_key, reflection| column_names.include? reflection.foreign_key }
  end

  # This method returns the same structure as foreign_key_columns (that is {foreign_key1: association_reflection1, ...}), only it includes foreign keys that are stored in other model's tables.
  def fk_to_association_hash
    reflections.inject({}) { |new_hash, (association_name, reflection)| new_hash[reflection.foreign_key] = reflection; new_hash }
  end
end
