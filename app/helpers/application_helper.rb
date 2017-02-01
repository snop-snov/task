module ApplicationHelper
  def han(model, attribute)
    model.to_s.classify.constantize.human_attribute_name(attribute)
  end

  def need_checking?
    current_user.can_update?(Order) && Order.need_checking.count > 0
  end
end
