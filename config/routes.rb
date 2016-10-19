Rails.application.routes.draw do
  post 'ubi_mailer/send_default' => 'mailing#send_default', defaults: {format: :js}
end
