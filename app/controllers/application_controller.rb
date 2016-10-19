class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  include Encryptable

  before_action :check_token

  private

  def check_token
    token = decrypt params["ubi_mail"]["config_token"]
    unless token == Rails.application.secrets.mail_auth_token
      render json: {error: 'unauthorized'}, status: :unauthorized
    end
  end

end
