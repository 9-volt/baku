Baku::Application.routes.draw do
  devise_for :users
  root to: 'dashboard#index'

  mount Sidekiq::Web, at: '/sidekiq'

end
