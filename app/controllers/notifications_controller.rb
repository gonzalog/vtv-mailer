class NotificationsController < ApplicationController
  skip_before_action(:verify_authenticity_token, only: :create)

  def create
    @notifications = Notification.send_to_many(
      notifications_params[:clients],
      notifications_params[:email],
      notifications_params[:password])
  end

  private
  def notifications_params
    params.require(:notifications).permit(:email, :password, clients: [:expiration_date, :certificate_id, :domain, :email])
  end
end
