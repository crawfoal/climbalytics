# Try to think of a better name for these methods...
module KeyInspector

  def has_fk?(column_name)
    fk_hash[column_name.to_s] ? true : false
  end

  def association_for(column_name)
    reflect_on_association(fk_hash[column_name.to_s])
  end

  private

  def fk_hash
    cache_fk_hash
    @fk_hash
  end

  def cache_fk_hash
    @fk_hash ||= {}
    belongs_to_associations = reflect_on_all_associations(:belongs_to)
    if @fk_hash.size != belongs_to_associations.size
      @fk_hash = belongs_to_associations.inject({}) do |hash, association|
        hash[association.foreign_key] = association.name if column_names.include? association.foreign_key
        hash
      end
    end
  end

end
