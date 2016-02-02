module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize

    direction = (column == params[:sort] && params[:direction] == "asc")? "desc" : "asc"

    cls = "sortable"
    if column == params[:sort]
      cls = params[:direction]
    end

    link_to title, {sort: column, direction: direction}, :class => cls
  end
end
