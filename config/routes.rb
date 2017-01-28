Rails.application.routes.draw do
  scope module: :web do
    resource :schedule, only: [:new, :create]
  end
end
