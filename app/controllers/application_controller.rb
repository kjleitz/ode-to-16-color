class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # after_action :verify_authorized, except: [:index]
  # after_action :verify_policy_scoped, only: [:index]

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Your session has expired. Please log in again."
    redirect_to root_path
  end

  def set_current_user(user)
    session[:user_id] = user.is_a?(User) ? user.id : user;
  end

  def clear_current_user
    session.delete(:user_id)
  end

  def logged_in?
    !!current_user
  end

  def validation_failure_for(record, as: :html)
    case as
    when :json then { json: { record.errors.messages }, status: :unprocessable_entity }
    when :html then { status: :unprocessable_entity, alert: record.errors.full_messages.to_sentence }
    when :text then { text: record.errors.full_messages.to_sentence, status: :unprocessable_entity }
    end
  end

  private

  def user_not_authorized(error)
    if !logged_in?
      flash[:error] = "You must be logged in to access that page."
      redirect_to login_path
    else
      flash[:error] = "You are not authorized to perform that action."
      redirect_to request.referrer || root_path
    end
  end
end
