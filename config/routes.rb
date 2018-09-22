# frozen_string_literal: true

Rails.application.routes.draw do
  resources :urls, only: %i[index create destroy]
  match '/:random_string', to: 'urls#redirect', via: :all
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
