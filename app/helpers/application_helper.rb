module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize

    direction =  'asc'
    if(column == params[:sort] && params[:direction] == "asc")
      direction = 'desc'
    end

    cls = "sortable"
    if column == params[:sort]
      cls = params[:direction]
    end

    link_to title, params.merge({sort: column, direction: direction}), :class => cls
  end
end
