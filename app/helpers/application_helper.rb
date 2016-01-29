module ApplicationHelper
  def page_stylesheet(controller, action)
    "pages/#{controller}/#{action}"
  end
end
