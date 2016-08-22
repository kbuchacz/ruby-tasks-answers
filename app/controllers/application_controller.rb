class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :ensure_json_request

  def ensure_json_request
    return if request.format == :json
    respond_with_not_acceptable
  end

  def respond_with_errors(object)
    render json: ErrorSerializer.serialize(object), status: :unprocessable_entity
  end

  def respond_with_not_found(message)
    render json: ErrorSerializer.serialize_not_found(message), status: :not_found
  end


  def respond_with_not_acceptable
    render json: ErrorSerializer.request_not_acceptable, status: :not_acceptable
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    respond_with_not_found(e.message)
  end

  rescue_from ActionController::ParameterMissing do |e|
    render json: ErrorSerializer.bad_request(e.message), status: :bad_request
  end
end
