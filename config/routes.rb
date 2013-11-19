Baku::Application.routes.draw do
  require 'sidekiq/web'

  devise_for :users, skip: :registrations
  authenticate :user do
    root to: 'dashboard#index'
    mount Sidekiq::Web, at: '/sidekiq'
  end
end
