# frozen_string_literal: true

module Service
  class ValidateClient < Base
    def call
      validate_parameter_client_id
      return context if context.failure?

      validate_client
      return context if context.client_valid

      context.class_error = Service::Error::InvalidClient
      Service::ThrowError.call(context)
    end

    private

    def validate_parameter_client_id
      context.required_parameter = :client_id
      Service::ValidateParameter.call(context)
      context.client_valid = context.success?
    end

    def validate_client
      context.app = Application.find_by(client_id: context.client_id)
      context.client_valid = context.app.present?
    end
  end
end
