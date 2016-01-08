module RoleHelper
  def define_roles(*role_names)
    role_names.each do |role_name|
      Role.create! name: role_name
    end
  end
end
