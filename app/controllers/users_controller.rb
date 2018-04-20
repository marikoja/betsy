class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    if auth_hash['uid']
      @user = User.find_by(uid: auth_hash[:uid], provider: 'github')
      if @user.nil?
        @user = User.build_from_github(auth_hash)
        successful_save = @user.save
        if successful_save
          flash[:success] = "Logged in successfully"
          session[:user_id] = @user.id
          redirect_to root_path
        else
          flash[:error] = "Something happened at user creation"
          redirect_to root_path
        end
      else
        flash[:success] = "Logged in successfully"
        session[:user_id] = @user.id
        redirect_to root_path
      end
    end
  end

  def edit
  end

  def update
  end
end
