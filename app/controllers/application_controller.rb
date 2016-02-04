class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout "bootstrap"


  def sort_params
    sort = params[:sort] || 'id'
    direction = params[:direction] || 'asc'

    sort + ' '  + direction
  end

  def search_params
    params[:q]
  end


  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

end
