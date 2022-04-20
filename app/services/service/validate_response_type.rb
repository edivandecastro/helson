# frozen_string_literal: true

module Service
  class ValidateResponseType < Base
    def call
      validate_parameter_response_type
      return context if context.failure?

      context.response_type_valid = context.response_type == 'code'
      return context if context.response_type_valid

      context.class_error = Service::Error::InvalidResponseType
      Service::ThrowError.call(context)
    end

    private

    def validate_parameter_response_type
      context.required_parameter = :response_type
      Service::ValidateParameter.call(context)
      context.response_type_valid = context.success?
    end
  end
end
