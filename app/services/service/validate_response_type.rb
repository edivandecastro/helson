# frozen_string_literal: true

module Service
  class ValidateResponseType < Base
    def call
      context.validate_response_type = context.response_type == 'code'
      context.fail(error) unless context.validate_response_type
      context
    end

    private

    def error
      {
        status: 400, # move to constant
        type: :invalid_request, # move to constant
        message: "Invalid response_type: #{context.response_type}", # move translate
      }
    end
  end
end
