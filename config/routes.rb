Rails.application.routes.draw do
  root "pages#homepage"

  devise_for :mentees, path: "mentees", controllers: {
    sessions: "mentees/sessions",
    registrations: "mentees/registrations"
  }

  devise_for :admins, path: "admins", controllers: {
    sessions: "admins/sessions",
    registrations: "admins/registrations"
  }

  devise_for :mentors, path: "mentors", controllers: {
    sessions: "mentors/sessions",
    registrations: "mentors/registrations"
  }

  devise_scope :mentee do
    namespace :mentees do
      get "dashboard", as: :dashboard, to: "dashboard#index"
    end
  end

  devise_scope :mentor do
    namespace :mentors do
      get "dashboard", as: :dashboard, to: "dashboard#index"
    end
  end

  namespace :admin do
    resources :mentors
    resources :mentees
    resources :matches
    get "dashboard", to: "dashboard#index"
    post "run_match_service", to: "dashboard#run_match_service"
    post "approve_matches", to: "matches#approve_matches"
  end

  resources :meetings
  resources :tasks
  resources :projects
  resources :mentorships
  resources :mentors, only: [:new, :create, :edit, :update] do
    resources :onboarding, only: [:new, :create], controller: "mentor_onboarding"
  end

  resources :mentees, only: [:new, :create, :edit, :update] do
    resources :onboarding, only: [:new, :create], controller: "mentee_onboarding"
  end
end
