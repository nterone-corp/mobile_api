Rails.application.routes.draw do

  mount MobileApi::Engine => "/mobile_api"
end
