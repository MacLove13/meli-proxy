Rails.application.routes.draw do
  resources :limit_ip_paths, path: 'admin'
  
  namespace 'monitor' do
    get '/', action: :index
  end
  
  get 'proxy/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
