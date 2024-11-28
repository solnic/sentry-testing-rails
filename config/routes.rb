Rails.application.routes.draw do
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  get "/heavy-work" => "hello#heavy"
  get "/heavy-work-sp" => "hello#heavy_sp"
  get "/repo" => "hello#repo"
  get "/error-with-attachment" => "hello#error_with_attachment"
  get "/error-with-locals" => "hello#error_with_locals"
  get "/error-faraday" => "hello#error_faraday"
  get "/cache" => "hello#cache"

  get "/crash" => "hello#crash"
  post "/crash" => "hello#crash"

  get "/schedule-hello-world" => "hello#schedule_hello_world"

  get "/error-excon" => "hello#error_excon"

  get "/repo-excon" => "hello#repo_excon"
end
