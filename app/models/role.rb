class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify

  after_save 'self.class.cache_defined_roles'
  def self.cache_defined_roles
    cache = self.unscoped.all.map { |role| role.name  }
    self.singleton_class.instance_eval do
      define_method 'defined_roles' do
        cache
      end
    end
  end

  def self.method_missing(name, *args, &block)
    if name == :defined_roles
      cache_defined_roles
      defined_roles
    else
      super
    end
  end

end
