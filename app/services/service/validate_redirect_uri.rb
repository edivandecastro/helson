# frozen_string_literal: true

module Service
  class ValidateRedirectUri < Base
    def call
      context.validate_redirect_uri = app_include_redirect_uri?
      context.fail(error) if app_not_include_redirect_uri?
      context
    end

    private

    def app_include_redirect_uri?
      app = context.app || Application.find_by(client_id: context.client_id)
      return false if app.nil?

      app.redirect_uri.include?(context.redirect_uri)
    end

    def app_not_include_redirect_uri?
      !app_include_redirect_uri?
    end

    def error
      {
        statu: 400,
        type: :redirect_uri_mismatch,
        message: "Unable to sign in to the app because it doesn't comply with OAuth 2.0 policy. If you are the app developer, record the redirect URI in the your application.",
      }
    end
  end
end
