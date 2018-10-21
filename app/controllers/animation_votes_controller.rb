class AnimationVotesController < ApplicationController
  before_action :set_animation, only: [:create, :update, :destroy]
  before_action :set_vote, only: [:update, :destroy]

  def create
    vote = animation.votes.where(user_id: current_user.id).first_or_initialize(animation_vote_params)
    if authorize(vote).save
      render json: vote, status: :created
    else
      render validation_failure_for vote, as: :json
    end
  end

  def update
    if authorize(@vote).update(animation_vote_params)
      render json: @vote, status: :ok
    else
      render validation_failure_for @vote, as: :json
    end
  end

  def destroy
    if authorize(@vote).destroy
      render status: :no_content
    else
      render validation_failure_for @vote, as: :json
    end
  end

  private

  def animation_vote_params
    params.require(:animation_vote).permit(:value)
  end

  def set_animation
    @animation ||= Animation.find_by(id: params[:animation_id]) || render status: :not_found
  end

  def set_vote
    @vote ||= begin
      set_animation
      @animation.votes.find_by(id: params[:id]) || render status: :not_found
    end
  end
end
