Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'projects#index'
  resources :projects
  get 'download_input', to: 'testcases#download_input'
  get 'download_output', to: 'testcases#download_output'
  post '/download-attachments', to: "projects#process_and_create_zip_file", as: 'download_documents'
  post 'generate_output', to: 'projects#generate_output'
  get 'add_code', to: 'projects#add_code'
  get 'online_ide', to: 'projects#online_ide'
end
