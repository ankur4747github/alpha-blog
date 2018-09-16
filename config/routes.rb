Rails.application.routes.draw do
   root 'pages#home'
   get 'pages/about' => 'pages#about'
   get 'pages/home' => 'pages#home'
   resources :articles

   get 'signup' => 'users#new'
   #post 'users' => 'users#create'
   resources :users, except: [:new]
   get 'login' => 'sessions#new'
   post 'login' => 'sessions#create'
   delete 'logout' => 'sessions#destroy'

   resources :categories

end
