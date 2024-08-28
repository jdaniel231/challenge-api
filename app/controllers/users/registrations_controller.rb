# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if request.method == "POST" && resource.persisted?
      render json: {
        message: "Signed up successfully.",
        data: resource
      }, status: :ok
    elsif request.method == "DELETE"
      render json: {
        message: "Account deleted successfully."
      }, status: :ok
    else
      render json: {
        status: { code: 422, message: "User couldn't be created successfully." },
        errors: resource.errors.full_messages
      }, status: :unprocessable_entity
    end
  end
end
