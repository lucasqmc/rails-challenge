Rails.application.routes.draw do
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post "url_shortener" => "url_shortener#generate_short_url"

  get "top_100_urls" => "url_shortener#top_100_urls"

  get "/:link_hash" => "url_shortener#redirect_to_short_link_url"



  # Defines the root path route ("/")
  root "posts#index"
end
