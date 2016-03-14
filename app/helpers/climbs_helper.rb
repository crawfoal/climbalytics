module ClimbsHelper
  def link_to_edit_loggable(climb, name = nil, html_options = nil, &block)
    url = method(climb.loggable_type.underscore + '_path').call(climb.loggable)
    link_to(name, url, html_options, &block)
  end
end
