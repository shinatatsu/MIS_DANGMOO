Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/dangmoo/eat', to: 'dangmoo#eat'
  get '/dangmoo/sent_request', to: 'dangmoo#sent_request'
end
