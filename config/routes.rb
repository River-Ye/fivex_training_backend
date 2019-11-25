Rails.application.routes.draw do
  resources :tasks do
    collection do
      get :search
    end
  end

  root 'tasks#index'
end