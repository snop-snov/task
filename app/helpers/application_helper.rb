module ApplicationHelper
  def need_checking?
    Order.need_checking.count > 0
  end
end
