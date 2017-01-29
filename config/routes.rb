Rails.application.routes.draw do
  scope module: :web do
    resource :schedule, only: [:new, :create]
    resource :session, only: [:new, :create, :destroy]
    resources :orders, only: [:index, :edit, :update]
    resources :delivery_loads, only: [:index, :new, :edit, :update, :create]

    root 'welcome#index'
  end
end
