module IndexInspector
  extend ActiveSupport::Concern

  module ClassMethods
    # Why isn't a method like this already defined? Is there a catch I'm missing? E.g. maybe a model can be stored in multiple tables?
    def index_exists?(column_name, options = {})
      connection.index_exists?(table_name.to_sym, column_name, options)
    end
  end
end
