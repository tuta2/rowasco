class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_action :authorized!
  load_and_authorize_resource 

  def index
    @services = Service.all
  end

  def show; end

  def new
    @service = Service.new
    @orders = Order.all
  end

  def edit; end

  def create
    @service = Service.new(service_params)
    @orders = Order.all

    respond_to do |format|
      if @service.save
        format.html { 
          redirect_to '/services', notice: "Service Booked" 
        }
      else
        format.html {render 'services/new', status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to "/services", notice: "service Updated" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to "/services", notice: "Service Removed" }
    end
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:service_type, :service_quantity, :price, :order_id)
  end
end
