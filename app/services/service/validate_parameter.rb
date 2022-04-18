# frozen_string_literal: true

module Service
  class ValidateParameter < Base
    def call
      required_parameter = context.required_parameter
      if context.send(required_parameter).nil? || context.send(required_parameter).to_s.empty?
        context.class_error = Service::Error::MissingRequiredParameter
        Service::ThrowError.call(context)
      end
      context
    end
  end
end
