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
