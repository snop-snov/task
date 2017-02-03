Rails.application.routes.draw do
  scope module: :web do
    resource :schedule, only: [:show, :new, :create]
    resource :session, only: [:new, :create, :destroy]
    resources :orders, only: [:index, :edit, :update]
    resources :delivery_loads, only: [:index, :new, :edit, :update, :create] do
      member do
        get :download
      end
    end

    root 'welcome#index'
  end
end
