class UsersController < ApplicationController
  def index
    @merchants = User.all
  end

  def show
    @merchant = User.find_by(id: params[:id])
  end

  def new
    @merchant = User.new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    if auth_hash['uid']
      @merchant = User.find_by(uid: auth_hash[:uid], provider: 'github')
      if @merchant.nil?
        @merchant = User.build_from_github(auth_hash)
        successful_save = @merchant.save
        if successful_save
          flash[:success] = "Logged in successfully"
          session[:user_id] = @merchant.id
          redirect_to root_path
        else
          flash[:error] = "Something happened at user creation"
          redirect_to root_path
        end
      else
        flash[:success] = "Logged in successfully"
        session[:user_id] = @merchant.id
        redirect_to root_path
      end
    end
  end

  def edit
  end

  def update
  end
end
