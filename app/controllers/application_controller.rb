class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :authenticate_user!

  skip_before_action :authenticate_user!, if: :devise_controller?

  private

  def authenticate_user!
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
