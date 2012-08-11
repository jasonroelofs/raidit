module NavigationHelper
  def nav_link_class(page_key)
    if current_navigation == page_key
      "active"
    else
      ""
    end
  end
end
