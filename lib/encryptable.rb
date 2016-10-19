require 'aes'

module Encryptable

  def encrypt(plaintext)
    cipher = AES.encrypt(plaintext, key, format: :plain)
    cipher.map { |c| encode(c) }.join(':')
  end

  def decrypt(ciphertext)
    begin
      ciphertext = ciphertext.split(':').map { |c| decode(c) }
      AES.decrypt(ciphertext, key, format: :plain)
    rescue => e
      raise "Bad decrypt of hashed api auth token. Possibly need to re-encrypt against new secret auth token?"
    end
  end

  private
  def key
    raise "MAIL_AUTH_TOKEN must be set as an envirement variable in order to run this tool. See the READ.me for more information" unless Rails.application.secrets.mail_key.present?
    Rails.application.secrets.mail_key
  end

  def encode(str)
    str.unpack('H*').first
  end

  def decode(str)
    [str].pack('H*')
  end
end
