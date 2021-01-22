Rails.application.routes.draw do
  resources :projects do
    post '/check_investment', on: :member, action: :check_investment
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
