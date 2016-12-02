class ConnectionsController < ApplicationController
  before_action :set_connection, only: [:destroy]
  before_action :set_interface

  # GET /connections/new
  def new
    @connection = Connection.new
    @connection.origin_interface = @interface
  end

  # POST /connections
  # POST /connections.json
  def create
    @connection = Connection.new(connection_params)
    @connection.origin_interface = @interface

    respond_to do |format|
      if @connection.save
        format.html { redirect_to device_interfaces_url(@interface.device), notice: 'Connection was successfully created.' }
        format.json { render :show, status: :created, location: @connection }
      else
        format.html { render :new }
        format.json { render json: @connection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /connections/1
  # DELETE /connections/1.json
  def destroy
    @connection.destroy
    respond_to do |format|
      format.html { redirect_to device_interfaces_url(@interface.device), notice: 'Connection was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_connection
      @connection = Connection.find(params[:id])
    end

    def set_interface
      @interface = Interface.find(params[:interface_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def connection_params
      params.require(:connection).permit(:subject, :interface1_id)
    end
end
