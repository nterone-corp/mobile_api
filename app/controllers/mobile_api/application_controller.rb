module MobileApi
  class ApplicationController < ActionController::Base
    respond_to :json

    protect_from_forgery with: :exception

    skip_before_action :protect_from_forgery
    include Pundit

    around_action :handle_exceptions, if: proc { request.path.include?('/api') }

    # Catch exception and return JSON-formatted error
    def handle_exceptions
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
      json_response({ success: false, message: @message || e.class.to_s, errors: [{ detail: e.message }] }, @status) unless e.class == NilClass
    end

    def render_unprocessable_entity_response record
      render json: { success: false, model: record.class.name, message: record.errors.full_messages.join(', '), errors: record.errors }, status: 422
    end

    def json_response json, status
      render json: json, status: status
    end
  end
end
