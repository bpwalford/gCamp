module TasksHelper

  def sortable(title)

    if params[:sort] == "all"
      link_to_unless params[:tableSort] == title, title.titleize, tableSort: title, sort: :all
    else
      link_to_unless params[:tableSort] == title, title.titleize, tableSort: title, sort: :incomplete
    end

  end

  def task_true_false(task, sort, table_sort)

    if task.complete == false

      link_to content_tag(:span, "", class: "glyphicon glyphicon-unchecked"),

      toggleCompletion_path(currentId: task.id, currentSort: sort, currentTableSort: table_sort),

      class: "btn btn-default btn-sm"

    elsif task.complete == true

      link_to content_tag(:span, "", class: "glyphicon glyphicon-check"),

      toggleCompletion_path(currentId: task.id, sort: sort, tableSort: table_sort),

      class: "btn btn-default btn-sm"

    end

  end

end
