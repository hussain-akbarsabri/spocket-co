# frozen_string_literal: true

module ErrorHandler
  extend ActiveSupport::Concern
  included do
    # NOTE: rescue_from executed bottom-to-up.
    rescue_from StandardError do |e|
      # 　If you execute the following process,
      # it will be difficult to debug because the stack trace will not be displayed when an error occurs during Rspec execution.
      # For this reason, we do not execute it when testing.
      respond(:internal_server_error, e) unless Rails.env.test?
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      Rails.logger.info e
      flat_messages = e&.record&.errors&.map { |k, v| { k => v } }&.reduce({}, :merge)
      json = error_json(:unprocessable_entity, e, errors: flat_messages || e&.message)
      render json: json, status: :unprocessable_entity
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      respond(:not_found, e)
    end
  end

  private

  def respond(status, message)
    render json: error_json(status, message), status: status
  end

  def code_name_by_status(status)
    code = Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
    name = Rack::Utils::HTTP_STATUS_CODES[code]
    [code, name]
  end

  def error_json(status, error, hash = {})
    code, name = code_name_by_status(status)
    {
      status: code,
      error: name,
      exception: {
        class: error.class.to_s,
        message: error.message
      }
    }.reverse_merge(hash)
  end
end
