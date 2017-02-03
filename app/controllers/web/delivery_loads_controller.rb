class Web::DeliveryLoadsController < Web::ApplicationController
  authorize_actions_for DeliveryLoad, except: :download

  def index
    @q = DeliveryLoad.ransack(params[:q])
    @q.sorts = ['date desc', 'id'] if @q.sorts.empty?
    @delivery_loads = @q.result.page(params[:page])
  end

  def new
    @delivery_load = DeliveryLoad.new
  end

  def edit
    @delivery_load = DeliveryLoad.find params[:id]

    orders = Order.unassigned.for_date(@delivery_load.date)
    @orders_for_shift = orders.for_shift(@delivery_load.delivery_shift)
    @orders_not_for_shift = orders.not_for_shift(@delivery_load.delivery_shift)
  end

  def create
    @delivery_load = DeliveryLoad.new(delivery_load_params)

    if @delivery_load.save
      f(:success)
      redirect_to edit_delivery_load_path(@delivery_load)
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

  def download
    delivery_load = DeliveryLoad.find params[:id]
    authorize_action_for delivery_load

    respond_to do |format|
      format.csv { send_data delivery_load.to_csv, filename: delivery_load.file_name }
    end
  end

  private

  def delivery_load_params
    params.require(:delivery_load).permit(:date, :delivery_shift, order_ids: [])
  end
end
