# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ErrorHandler

  def empty_response
    render json: { message: 'No new customer is found' }, status: :ok
  end

  def success_response(data)
    render json: { data:, error: false }, status: :ok
  end
end
