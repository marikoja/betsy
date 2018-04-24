class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def account_views
    if @login_user.id != params[:id]
      flash[:status] = :error
      flash[:result_text] = "You can only view your personal account info"
      redirect_to root_path
    end
  end

  private
  def current_user
    if session[:user_id] != 1
      @login_user = User.find_by(id: session[:user_id])
    end
  end

end
