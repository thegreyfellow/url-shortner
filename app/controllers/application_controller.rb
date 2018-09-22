class ApplicationController < ActionController::API

  before_action :validate_token_and_permissions

  def current_user_id
    # your code goes here
  end

  private

  def validate_token_and_permissions
    return unauthorized unless validator.valid
  end

  def validator
    RequestValidator.new(
      token: request.headers['Authorization']
    ).run!
  end

  def unauthorized(message = 'Access denied')
    render status: 401, json: { message: message }
  end
end
