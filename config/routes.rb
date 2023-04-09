Rails.application.routes.draw do
  resources :meetings
  resources :tasks
  resources :projects
  resources :mentorships
  devise_for :mentees, path: "mentees", controllers: {
    sessions: "mentees/sessions",
    registrations: "mentees/registrations"
  }

  devise_for :mentors, path: "mentors", controllers: {
    sessions: "mentors/sessions",
    registrations: "mentors/registrations"
  }

  devise_scope :mentee do
    authenticated :mentee do
      namespace :mentees do
        get "dashboard/index", as: :authenticated_root
      end
    end
  end

  devise_scope :mentor do
    authenticated :mentor do
      namespace :mentors do
        get "dashboard/index", as: :authenticated_root
      end
    end
  end

  root "pages#homepage"
end
