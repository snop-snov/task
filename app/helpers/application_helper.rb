module ApplicationHelper
  def need_checking?
    current_user.can_update?(Order) && Order.need_checking.count > 0
  end
end
