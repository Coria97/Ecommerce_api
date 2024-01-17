class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :params_missing

  private

  def params_missing
    render json: { 'message': I18n.t('errors.bad_request') }, status: :bad_request
  end

  def record_not_found(exception)
    render json: { message: I18n.t('errors.not_fount', model: exception.model) }, status: :not_found
  end

  def page
    @page = params[:page]
  end

  def page_size
    @page_size = params[:page_size]
  end
end
