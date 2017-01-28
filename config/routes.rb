Rails.application.routes.draw do
  scope module: :web do
    resource :schedule, only: [:new, :create]
    resource :session, only: [:new, :create, :destroy]

    root 'welcome#index'
  end
end
