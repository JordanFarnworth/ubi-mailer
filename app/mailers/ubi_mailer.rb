require 'ostruct'
require 'sendgrid-ruby'

class UbiMailer < ApplicationMailer
  include SendGrid


  def default_email(params)
    mail_info = email_params(params)
    mail_info = assign_params(mail_info, params)
    @mail_info = mail_info
    from = Email.new(email: mail_info.from)
    subject = mail_info.from
    to = Email.new(email: mail_info.to)
    content = Content.new(type: 'text/plain', value: build_message)
    mail = Mail.new(from, subject, to, content)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    sg.client.mail._('send').post(request_body: mail.to_json)
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

  def build_message
    [
    "Source: #{@mail_info.source}",
    "Name: #{@mail_info.name_given}",
    "Email: #{@mail_info.email_given}",
    "Phone Number: #{@mail_info.phone_number_given}",
    "Message:",
    "#{@mail_info.message}",
    "Sent At: #{Time.zone.now}"
  ].join("\n\n")
  end

end
