class MobileApi::V1::BaseController < MobileApi::ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!
  after_action  :verify_authorized

  skip_before_action :verify_authenticity_token
end
