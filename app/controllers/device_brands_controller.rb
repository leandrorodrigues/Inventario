class DeviceBrandsController < ApplicationController
  before_action :set_device_brand, only: [:show, :edit, :update, :destroy]

  # GET /device_brands
  # GET /device_brands.json
  def index
    @device_brands = DeviceBrand.all
  end

  # GET /device_brands/1
  # GET /device_brands/1.json
  def show
  end

  # GET /device_brands/new
  def new
    @device_brand = DeviceBrand.new
  end

  # GET /device_brands/1/edit
  def edit
  end

  # POST /device_brands
  # POST /device_brands.json
  def create
    @device_brand = DeviceBrand.new(device_brand_params)

    respond_to do |format|
      if @device_brand.save
        format.html { redirect_to @device_brand, notice: 'Device brand was successfully created.' }
        format.json { render :show, status: :created, location: @device_brand }
      else
        format.html { render :new }
        format.json { render json: @device_brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /device_brands/1
  # PATCH/PUT /device_brands/1.json
  def update
    respond_to do |format|
      if @device_brand.update(device_brand_params)
        format.html { redirect_to @device_brand, notice: 'Device brand was successfully updated.' }
        format.json { render :show, status: :ok, location: @device_brand }
      else
        format.html { render :edit }
        format.json { render json: @device_brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /device_brands/1
  # DELETE /device_brands/1.json
  def destroy
    @device_brand.destroy
    respond_to do |format|
      format.html { redirect_to device_brands_url, notice: 'Device brand was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device_brand
      @device_brand = DeviceBrand.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_brand_params
      params.require(:device_brand).permit(:title)
    end
end
