Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    post '/users/fbasync' => "users/omniauth_callbacks#facebook_async"
  end
  root to: "home#index"
end
