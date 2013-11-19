Baku::Application.routes.draw do
  require 'sidekiq/web'

  devise_for :users
  root to: 'dashboard#index'

  mount Sidekiq::Web, at: '/sidekiq'

end
