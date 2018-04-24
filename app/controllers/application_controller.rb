class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def account_views
    @login_user = current_user
    if @login_user.id != params[:id].to_i

      flash[:status] = :failure
      flash[:result_text] = "Nice try, but you can't go there!"
      redirect_to root_path
    end
  end


  def current_user
    login_user = User.find_by(id: session[:user_id])
    if login_user.nil?
      login_user = User.first
    end
    return login_user
  end

end
