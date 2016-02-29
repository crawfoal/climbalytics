module ApplicationHelper
  def page_stylesheet
    page_stylesheet = "pages/#{scoped_controller_name}/#{action_name}"
    page_stylesheet
  end
  def scoped_controller_name
    if devise_controller?
      "#{resource_name.to_s.pluralize}/#{_controller_name}"
    else
      _controller_name
    end
  end
  def _controller_name
    params[:controller]
  end
end
