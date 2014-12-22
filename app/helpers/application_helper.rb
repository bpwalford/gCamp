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

  def page_header2(title, &block)
    content_for(:title, title)
    content_tag(:div, class: "page-header") do
      concat(content_tag(:h1, title))
      concat(content_tag(:div, content_tag(:span, yield), class: "pull-right"))
    end
  end

end
