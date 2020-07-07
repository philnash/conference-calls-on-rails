# frozen_string_literal: true

Rails.application.routes.draw do
  resources :calls, only: [:create]
  post 'protected_calls/welcome', to: 'protected_calls#welcome'
  post 'protected_calls/verify', to: 'protected_calls#verify'
end
