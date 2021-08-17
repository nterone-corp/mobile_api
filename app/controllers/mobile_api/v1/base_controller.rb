class MobileApi::V1::BaseController < Api::Mobile::BaseController
  include Pundit

  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!
  after_action  :verify_authorized

  # disable CSRF protection
  protect_from_forgery with: :null_session

  respond_to :json

  skip_before_action :protect_from_forgery

  around_action :mobile_api_handle_exceptions, if: proc { request.path.include?('/api') }

  # Catch exception and return JSON-formatted error
  def mobile_api_handle_exceptions
    begin
      yield
    rescue ActiveRecord::RecordNotFound => e
      @status = 404
      @message = 'Record not found'
    rescue ActiveRecord::RecordInvalid => e
      render_unprocessable_entity_response(e.record) && return
    rescue ArgumentError => e
      @status = 400
    rescue StandardError => e
      @status = 500
    end
    backtrace = !Rails.env.production? && e ? e.backtrace : []
    json_response({ success: false, message: @message || e.class.to_s, errors: [{ detail: e.message }], backtrace: backtrace }, @status) unless e.class == NilClass
  end

  def render_unprocessable_entity_response record
    render json: { success: false, model: record.class.name, message: record.errors.full_messages.join(', '), errors: record.errors }, status: 422
  end

  def json_response json, status
    render json: json, status: status
  end

end
