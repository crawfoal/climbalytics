module RoleHelper
  def define_roles(*role_names)
    role_names.each do |role_name|
      Role.create! name: role_name
    end
  end
  def undefine_roles(*role_names)
    role_names.each do |role_name|
      role = Role.find_by(name: role_name)
      role.destroy if role
    end
  end
end

RSpec.configure do |config|
  config.include RoleHelper

  include RoleHelper

  # The following is defined in the before :suite hook in rails_helper.rb, so that we can be sure that it runs after DatabaseCleaner truncates all tables.
  # config.before(:suite) do
  #   define_roles(:setter,:athlete)
  # end

  config.after(:suite) do
    undefine_roles(:setter,:athlete)
  end

end
