# frozen_string_literal: true

module Service
  class ThrowError < Base
    def call
      error = context.class_error.new(context)
      context.fail(
        {
          type: error.type,
          status: error.status,
          message: error.message,
        }
      )
      context
    end
  end
end
