class MailingController < ApplicationController

  def send_default
    UbiMailer.default_email(email_params).deliver_now
    render json: {success: "email will be delivered"}, status: :ok
  end

  private

  def email_params
    params.require(:ubi_mail).permit(:config_token, :email_address, :name, :phone, :message)
  end

end
