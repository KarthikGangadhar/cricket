Rails.application.routes.draw do
  get 'ballbyball/show'

  get 'cricket/show'

  get 'home/show'
  root 'home#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
