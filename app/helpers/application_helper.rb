module ApplicationHelper
  def page_stylesheet
    page_stylesheet = "pages/#{scoped_controller_name}/#{params[:action]}"
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

  # just like `link_to`, only wraps content in a div with a class of 'inner'
  def link_with_inner_div_to(name = nil, url_options = {}, html_options = {}, &block)
    link_to url_options, html_options do
      content_tag :div, class: 'inner' do
        name or block.call
      end
    end
  end
end
