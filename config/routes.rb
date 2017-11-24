Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  post "redis" => "redis#create"
  delete "redis" => "redis#destroy"
end
