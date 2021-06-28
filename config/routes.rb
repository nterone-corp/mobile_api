MobileApi::Engine.routes.draw do
  namespace :v1 do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      sessions: 'api/mobile/v1/user_sessions'
    }

    get '/models/:type/:id', to: 'models#show'
    get '/models/:type', to: 'models#index'
  end
end
