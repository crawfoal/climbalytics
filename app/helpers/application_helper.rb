module ApplicationHelper
  def scoped_controller_name
    if devise_controller?
      "#{resource_name.to_s.pluralize}/#{_controller_name}"
    else
      _controller_name
    end
  end

  def dashboard_path_for(user)
    try("#{user.current_role}_dashboard_path")
  end

  private

  def _controller_name
    params[:controller]
  end
end
