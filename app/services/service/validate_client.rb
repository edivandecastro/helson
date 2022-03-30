module Service
  class ValidateClient < Base
    def call
      app = Application.find_by(client_id: context.client_id)
      context.client_valid = app ? true : false
      context.fail(error: "The OAuth client was not found.") if app.nil?
      context
    end
  end
end
