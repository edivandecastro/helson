# frozen_string_literal: true

module Service
  class ValidateScope < Actor
    input :application
    input :scopes
    output :scope_valid
    output :scope_invalid

    def call
      self.application ||= Oauth::Application.find_by(client_id: self.application.client_id)
      separate_scopes
      return if self.scope_invalid.empty?

      fail!(error: I18n.t('services.errors.invalid_scope',
            scope_valid: self.scope_valid.join(', '), scope_invalid: self.scope_invalid.join(', ')))
    end

    private

    def separate_scopes
      self.scope_valid = []
      self.scope_invalid = []
      application_scopes = self.application.scopes.split

      scopes.split.each do |scope|
        application_scopes.include?(scope) ? self.scope_valid.push(scope) : self.scope_invalid.push(scope)
      end
    end
  end
end
