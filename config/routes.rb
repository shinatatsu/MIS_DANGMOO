Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/dangmoo/eat', to: 'dangmoo#eat'
  post '/dangmoo/webhook', to: 'dangmoo#webhook'
end
