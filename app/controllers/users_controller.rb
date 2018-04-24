class UsersController < ApplicationController

  before_action :account_views, only: [:show, :edit]

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
          session[:uid] = @user.uid
          session[:user_id] = @user.id
          session[:uid] = @user.uid
          binding.pry
          redirect_to root_path
        else
          flash[:error] = "Something happened at user creation"
          redirect_to root_path
        end
      else
        flash[:success] = "Logged in successfully"
        session[:uid] = @user.uid
        session[:user_id] = @user.id
        redirect_to root_path
      end
    end
  end

  def edit
    @user = User.find_by(uid: session[:uid])
  end

  def update
    @user = User.find_by(uid: session[:uid])
    if @user
      @user.update(user_params)
      flash[:success] = "#{@user.name} updated"
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "Failed to update"
      render :edit
    end
  end

  def destroy
    session[:user_id] = nil
    session[:order] = nil
    redirect_to root_path
  end

  private

  def user_params
    return params.require(:user).permit(:name, :email)
  end
end
