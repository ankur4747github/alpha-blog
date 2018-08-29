Rails.application.routes.draw do
   root 'pages#home'
   get 'pages/about' => 'pages#about'
   get 'pages/home' => 'pages#home'
   resources :articles
end
