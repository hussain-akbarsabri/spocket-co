# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ErrorHandler

  def success_response(data)
    render json: { data:, error: false }, status: :ok
  end
end
