require 'sidekiq/web'

Rails.application.routes.draw do
  get 'members/create'

  get 'members/destroy'

  get 'members/update'

  get 'pages/home'

  devise_for :users, :controllers => { registrations: 'registrations' }
  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
