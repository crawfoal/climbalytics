module ApplicationHelper
  def page_stylesheet(controller, action)
    page_stylesheet = "pages/#{controller}/#{action}"
    page_stylesheet['devise'] = resource_name.to_s.pluralize if resource_name and page_stylesheet['devise']
    page_stylesheet
  end
end
