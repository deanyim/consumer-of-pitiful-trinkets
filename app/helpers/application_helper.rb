module ApplicationHelper

  # Returns the full title
  def full_title(page_title = '')
    base_title = "Consumer of Pitiful Trinkets"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
