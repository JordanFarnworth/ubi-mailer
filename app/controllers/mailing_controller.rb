class MailingController < ApplicationController

  def send_default
    UbiMailer.default_email(email_params).deliver_now
    response.headers['Access-Control-Allow-Origin'] = 'https://jordanfarnworth.github.io'
    render json: {success: "email will be delivered"}, status: :ok, :callback => params[:callback]
  end

  private

  def email_params
    params.require(:ubi_mail).permit(:config_token, :email_address, :name, :phone, :message)
  end

end
