# frozen_string_literal: true

module Service
  class ValidateRedirectUri < Base
    def call
      validate_parameter_redirect_uri
      return context if context.failure?

      context.redirect_uri_valid = app_include_redirect_uri?
      return context if context.redirect_uri_valid

      context.class_error = Service::Error::RedirectUriMismatch
      Service::ThrowError.call(context)
    end

    private

    def validate_parameter_redirect_uri
      context.required_parameter = :redirect_uri
      Service::ValidateParameter.call(context)
      context.redirect_uri_valid = context.success?
    end

    def app_include_redirect_uri?
      app = context.app || Application.find_by(client_id: context.client_id)
      return false if app.nil?

      context.redirect_uri.include?(app.redirect_uri)
    end
  end
end
