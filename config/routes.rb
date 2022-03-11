Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end

  constraints Clearance::Constraints::SignedIn.new { |user| user.admin? } do
    scope module: :admin, as: :admin do
      resources :dashboard, only: [:index]
    end
  end

  constraints Clearance::Constraints::SignedIn.new { |user| user.guardian? } do
    scope module: :guardian, as: :guardian do
      resources :dashboard, only: [:index]
    end
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
end
