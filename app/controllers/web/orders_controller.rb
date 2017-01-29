class Web::OrdersController < Web::ApplicationController
  authorize_actions_for Order

  def index
    @q = Order.ransack(params[:q])
    @orders = @q.result.order(:delivery_date).page(params[:page])
  end

  def edit
    @order = Order.find params[:id]

    @order_states = @order.aasm.states(permitted: true).map(&:name)
    @order_states << @order.state unless @order_states.include? @order.state.to_sym
  end

  def update
    @order = Order.find params[:id]

    if @order.update(order_params)
      f(:success)
      redirect_to orders_path
    else
      render action: 'edit'
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :delivery_date, :delivery_shift, :client_name, :destination_raw_line_1,
      :destination_city, :destination_zip, :phone_number,
      :purchase_order_number, :volume, :handling_unit_quantity, :state
    )
  end
end
