Rails.application.routes.draw do

  get 'tasks/toggleCompletion' => 'tasks#toggleCompletion', as: :toggleCompletion

  resources :users
  resources :projects do
    resources :tasks do
      resources :comments, only: [:create]
    end
    resources :memberships
  end

  root "pages#index", as: :home

  get "about" => "about#index", as: :aboutPage

  get "terms" => "terms#index", as: :termsPage

  get "faq" => "faq#faq", as: :faqPage

  get "tracker_project/:tracker_id" => "projects#tracker", as: :tracker_project


  get "signup" => "register#new", as: :signup
  post "signup" => "register#create", as: :register
  get "signin" => "sessions#new", as: :signin
  post "signin" => "sessions#create", as: :signing_in
  get "signout" => "sessions#destroy", as: :signout

end
