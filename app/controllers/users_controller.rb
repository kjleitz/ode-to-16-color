class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show; end

  def new
    @user = authorize User.new
  end

  def edit; end

  def create
    @user = authorize User.new(user_params)
    if @user.save
      flash[:success] = "User '#{@user.handle}' created!"
      set_current_user(@user)
      redirect_to root_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User '#{@user.handle}' updated!"
      redirect_to user_path(@user)
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "User '#{@user.handle}' was deleted!"
      redirect_to root_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      redirect_to user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(*User::PERMITTED_ATTRS)
  end

  def set_user
    @user ||= authorize User.friendly.find(params[:id])
  end
end
