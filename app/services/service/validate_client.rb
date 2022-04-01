# frozen_string_literal: true

module Service
  class ValidateClient < Base
    def call
      context.app = Application.find_by(client_id: context.client_id)
      context.client_valid = context.app ? true : false
      context.fail(error) if context.app.nil?
      context
    end

    private

    def error
      {
        status: 401, # move to constant
        type: :invalid_client, # move to constant
        message: 'The OAuth client was not found.', # move translate
      }
    end
  end
end
