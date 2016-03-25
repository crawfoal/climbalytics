# http://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/
# Check this for security holes... what if someone sends in a scope or value they shouldn't really have access to (but is permitted in general)? Can we use pundit to help here? Can we prevent this method from doing anything unless the params array passed in has been filtered (maybe create `safe_params?` method that will indicate to the developer, during development - not production, that they forgot to use strong parameters?)? Try to find or think of a specific example of why it would be dangerous to not use `public_send` so that we can better understand the purpose.
# Why does he have the `if value.present?` conidition there? Can remove our version of it so that we can handle scopes that don't take parameters?
module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def search(search_params)
      # initialize with anonymous scope so that we can chain scopes in the loop:
      results = self.where(nil)
      search_params.each do |key, value|
        results = results.public_send(key, value) unless value.nil?
      end
      return results
    end
  end
end
