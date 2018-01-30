class Notification
  attr_reader(:message, :client_data, :from_email)

  def initialize(client_data, from_email, from_password)    
    @message = NotificationMailer.expiration_email(client_data, from_email, from_password)
    @client_data = client_data
    @from_email = from_email
  end

  def send
    self.message.deliver_now
  end

  class << self
    def send_to_many(clients, email, password)
      notifications = clients.map do |client_data|
        self.new(client_data, email, password)
      end

      notifications.each(&:send)

      notifications
    end
  end
end
