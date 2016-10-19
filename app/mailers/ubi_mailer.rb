require 'ostruct'

class UbiMailer < ApplicationMailer

  def default_email(params)
    mail_info = email_params(params)
    mail_info = assign_params(mail_info, params)
    @mail_info = mail_info
    mail(to: mail_info.to, subject: mail_info.subject, from: mail_info.from)
  end

  private

  def email_params(params)
    {
      from: "noreply@ubquitous.com",
      to: 'farnworth.jordan@gmail.com',
      subject: "Ubiquitous Mail from #{params["name"]}",
      source: 'Ubiquitous',
      email_given: params[:email_address],
      name_given: params[:name],
      phone_number_given: params[:phone],
      message: params[:message]
    }
  end

  def assign_params(mail_info, params)

    attrs = %i{from to subject source}
    attrs.each {|attr| mail_info[attr] = params[attr] if params[attr].present?}
    OpenStruct.new mail_info
  end
end
