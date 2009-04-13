# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def default_page_title
    "#{controller.controller_name} : #{controller.action_name}"
  end
  
end
