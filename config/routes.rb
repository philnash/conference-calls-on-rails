# frozen_string_literal: true

Rails.application.routes.draw do
  resources :calls, only: [:create]
  post 'protected_calls/welcome', to: 'protected_calls#welcome'
  post 'protected_calls/verify', to: 'protected_calls#verify'
  post 'verified_calls/welcome', to: 'verified_calls#welcome'
  post 'verified_calls/verify', to: 'verified_calls#verify'
end
