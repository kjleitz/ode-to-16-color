class SessionsController < ApplicationController
  def new
    redirect_to root_path and return if logged_in?
    @user = User.new
  end

  def create
    email, handle = session_params.values_at(:email, :handle)
    finder_attrs = email ? { email: email } : { handle: handle }
    user = User.friendly.find_by(**finder_attrs)
    if user && user.authenticate(session_params[:password])
      set_current_user(user.id)
      flash[:success] = "Logged in as #{user.handle}!"
      redirect_to root_path
    else
      flash[:error] = "Invalid login credentials. Please try again."
      redirect_to login_path
    end
  end

  def destroy
    clear_current_user
    flash[:success] = "Logged out!"
    redirect_to login_path
  end

  private

  def session_params
    params.require(:user).permit(:handle, :email, :password)
  end
end
