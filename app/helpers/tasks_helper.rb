module TasksHelper

  def sortable(title)

    if params[:sort] == "all"
      link_to_unless params[:tableSort] == title, title.titleize, tableSort: title, sort: :all
    else
      link_to_unless params[:tableSort] == title, title.titleize, tableSort: title, sort: :incomplete
    end

  end

end
