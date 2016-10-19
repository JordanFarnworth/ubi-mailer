Rails.application.routes.draw do
  get 'ubi_mailer/send_default' => 'mailing#send_default', defaults: {format: :js}
end
