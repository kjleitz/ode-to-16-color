class AnimationsController < ApplicationController
  before_action :set_animation, only: [:edit, :update, :destroy]

  def index
    @animations = scoped_animations
  end

  def show
    @animation = scoped_animations.friendly.find_by(id: params[:id])
    render status: 404 and return unless @animation.present?
  end

  def new
    @animation = current_user.animations.build
  end

  def edit; end

  def create
    @animation = current_user.animations.build(animation_params)
    binding.pry
    if @animation.save
      flash[:success] = "Animation '#{@animation.name}' created!"
      redirect_to animation_path(@animation)
    else
      flash[:error] = @animation.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @animation.update(animation_params)
      flash[:success] = "Animation '#{@animation.name}' updated!"
      redirect_to animation_path(@animation)
    else
      flash[:error] = @animation.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @animation.destroy
      flash[:success] = "Animation '#{@animation.name}' was deleted!"
      redirect_to animations_path
    else
      flash[:error] = @animation.errors.full_messages.to_sentence
      redirect_to animation_path(@animation)
    end
  end

  private

  def animation_params
    params.require(:animation).permit(
      *Animation::PERMITTED_ATTRS,
      tags_attributes: Tag::PERMITTED_ATTRS,
      frames_attributes: Frame::PERMITTED_ATTRS
    )
  end

  def set_animation
    @animation ||= authorize Animation.find(params[:id])
  end

  def scoped_animations
    @scoped_animations ||= if params[:user_id]
      user = User.friendly.friendly.find_by(id: params[:user_id])
      render status: 404 and return unless user.present?
      user.animations
    else
      Animation.all
    end
  end
end
