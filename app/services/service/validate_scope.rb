# frozen_string_literal: true

module Service
  class ValidateScope < Base
    def call
      validate_parameter_scopes
      return context if context.failure?

      app = context.app || Application.find_by(client_id: context.client_id)
      separate_scopes(scopes: app.scopes.split)
      context.scopes_valid = context.scope_invalid.empty?
      return context if context.scopes_valid

      context.class_error = Service::Error::InvalidScope
      Service::ThrowError.call(context)
    end

    private

    def validate_parameter_scopes
      context.required_parameter = :scopes
      Service::ValidateParameter.call(context)
      context.scopes_valid = context.success?
    end

    def separate_scopes(scopes:)
      context.scope_valid = []
      context.scope_invalid = []

      context.scopes.split.each do |scope|
        scopes.include?(scope) ? context.scope_valid.push(scope) : context.scope_invalid.push(scope)
      end
    end
  end
end
