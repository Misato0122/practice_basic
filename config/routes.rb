Rails.application.routes.draw do
  root 'static_pages#top'

  resources :users

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :boards, shallow: true do
    resources :comments, only: %i[create destroy]
    resource :bookmarks, only: [:create, :destroy]
    collection do
      get :bookmarks
    end
  end
end
