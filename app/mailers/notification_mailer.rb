class NotificationMailer < ApplicationMailer
  def expiration_email(client_data, from_email, from_password)
    client_email = client_data[:email]
    from_email = from_email
    from_password = from_password
    
    @expiration_date = client_data[:expiration_date]
    @certificate_id = client_data[:certificate_id]
    @domain = client_data[:domain]

    self.class.smtp_settings = {
      address: "smtp.#{get_domain(from_email)}",
      port: ENV["EMAIL_PORT"],
      domain: get_domain(from_email), 
      user_name: from_email, 
      password: from_password
    };

    mail(
      to: client_email,
      subject: "Vencimiento revisión técnica dominio #{@domain}")
  end

  private
  def get_domain(email)
    email.slice((email.index('@')+1)..(-1))
  end
end

