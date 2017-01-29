class Web::DeliveryLoadsController < Web::ApplicationController
  authorize_actions_for DeliveryLoad

  def index
    @q = DeliveryLoad.ransack(params[:q])
    @delivery_loads = @q.result.page(params[:page])
  end

  def new
    @delivery_load = DeliveryLoad.new
  end

  def edit
    @delivery_load = DeliveryLoad.find params[:id]
  end

  def create
    @delivery_load = DeliveryLoad.new(delivery_load_params)

    if @delivery_load.save
      f(:success)
      redirect_to delivery_loads_path
    else
      render action: 'new'
    end
  end

  def update
    @delivery_load = DeliveryLoad.find params[:id]

    if @delivery_load.update(delivery_load_params)
      f(:success)
      redirect_to delivery_loads_path
    else
      render action: 'edit'
    end
  end

  private

  def delivery_load_params
    params.require(:delivery_load).permit(:date, :delivery_shift, :driver_id)
  end
end
