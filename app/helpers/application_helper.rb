module ApplicationHelper
  #return the full tittle of each pages
    def full_title (page_title = '')
        base_title = "Ruby on Rails Tutorials Sample App"
        if page_title.empty?
            base_title
        else 
            "#{ page_title} | #{base_title}"
        end
    end
end
