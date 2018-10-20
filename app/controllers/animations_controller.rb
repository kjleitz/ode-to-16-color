class AnimationsController < ApplicationController
  before_action :set_user, only: [:new, :create]
  before_action :set_animation, only: [:edit, :update, :destroy]

  def index
    @animations = scoped_animations
  end

  def show
    @animation = scoped_animations.find_by(params[:id])
    render status: 404 and return unless @animation.present?
  end

  def new
    @animation = @user.animations.build
  end

  def edit; end

  def create
    @animation = @user.animations.build(animation_params)
    if @animation.save
      flash[:success] = "Animation '#{@animation.name}' created!"
      redirect_to action: :show
    else
      flash[:error] = @animation.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @animation.update(animation_params)
      flash[:success] = "Animation '#{@animation.name}' updated!"
      redirect_to action: :show
    else
      flash[:error] = @animation.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @animation.destroy
      flash[:success] = "Animation '#{@animation.name}' was deleted!"
      redirect_to action: :index
    else
      flash[:error] = @animation.errors.full_messages.to_sentence
      redirect_to action: :show
    end
  end

  private

  def animation_params
    require(:animation).permit(
      *Animation::PERMITTED_ATTRS,
      tags_attributes: Tag::PERMITTED_ATTRS,
      frames_attributes: Frame::PERMITTED_ATTRS
    )
  end

  def set_user
    @user ||= User.find(params[:user_id])
  end

  def set_animation
    @animation ||= authorize Animation.find(params[:id])
  end

  def scoped_animations
    @scoped_animations ||= if params[:user_id]
      user = User.find_by(params[:user_id])
      render status: 404 and return unless user.present?
      user.animations
    else
      Animation.all
    end
  end
end
