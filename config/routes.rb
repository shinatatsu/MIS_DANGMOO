Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/dangmoo/eat', to: 'dangmoo#eat'
  get '/dangmoo/request_headers', to: 'dangmoo#request_headers'
  get '/dangmoo/request_body', to: 'dangmoo#request_body'
  get '/dangmoo/response_headers', to: 'dangmoo#response_headers'
  get '/dangmoo/response_body', to: 'dangmoo#show_response_body'
  get '/dangmoo/sent_request', to: 'dangmoo#sent_request'
  post '/dangmoo/webhook', to: 'dangmoo#webhook'
end
