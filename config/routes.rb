Rails.application.routes.draw do
  root 'sites#index'

  resources :sites do
    resources :captured_versions
  end
  resources :composited_screenshots
end
