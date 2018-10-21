class CommentVotesController < ApplicationController
  before_action :set_comment, only: [:create, :update, :destroy]
  before_action :set_vote, only: [:update, :destroy]

  def create
    vote = comment.votes.where(user_id: current_user.id).first_or_initialize(comment_vote_params)
    if authorize(vote).save
      render json: vote, status: :created
    else
      render validation_failure_for vote, as: :json
    end
  end

  def update
    if authorize(@vote).update(comment_vote_params)
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

  def comment_vote_params
    params.require(:comment_vote).permit(:value)
  end

  def set_comment
    @comment ||= Comment.find_by(id: params[:comment_id]) || render status: :not_found
  end

  def set_vote
    @vote ||= begin
      set_comment
      @comment.votes.find_by(id: params[:id]) || render status: :not_found
    end
  end
end
