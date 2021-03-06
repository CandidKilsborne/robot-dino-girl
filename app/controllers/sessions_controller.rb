class SessionsController < ApplicationController
  def new
    @user = User.new
    render layout: "login"
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url#, :notice => "You logged in!"
    else
      @error = "Invalid email or password!"
      @user = User.new
      render :new, layout: "login"
    end
  end

  def destroy
    session.delete(:user_id)
    @user = User.new
    # render :new, layout: "login"
    redirect_to root_url
  end
end
