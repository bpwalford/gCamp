module ApplicationHelper

  def crumbs(links)

    content_tag(:ol, class: "breadcrumb") do
      links.each do |item|
        if item[:link] == "active"
          concat(content_tag(:li, item[:name]))
        else
          concat(content_tag(:li, content_tag(:a, item[:name], href: item[:link])))
        end
      end
    end

  end

end
