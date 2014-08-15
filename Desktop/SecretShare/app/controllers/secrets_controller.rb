class SecretsController < ApplicationController
  before_filter :require_current_user!

  def create
    @secret = current_user.authored_secrets.new(secret_params)
    if @secret.save
      redirect_to user_url(current_user)
    else
      render :new
    end
  end

  def new
    @secret = Secret.new
    render :new
  end

  private
  def secret_params
    params.require(:secret).permit(:title, :recipient_id, title_ids: [])
  end
end
