Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'projects#index'
  resources :projects
  get 'download_product', to: 'testcases#download'
  post '/download-attachments', to: "projects#process_and_create_zip_file", as: 'download_documents'
end
