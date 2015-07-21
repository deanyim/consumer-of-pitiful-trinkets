module ApplicationHelper

  # Returns the full title
  def full_title(page_title = '')
    base_title = "Spider With 1000 Eyes"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
