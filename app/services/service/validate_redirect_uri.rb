# frozen_string_literal: true

module Service
  class ValidateRedirectUri < Actor
    input :client_id, type: String, allow_nil: false
    input :application
    input :redirect_uri, type: String

    def call
      self.application ||= Application.find_by(client_id: self.application.client_id)
      return if application_include_redirect_uri?

      fail!(error: I18n.t('services.errors.redirect_uri_mismatch').join(' '))
    end

    private

    def application_include_redirect_uri?
      self.redirect_uri.include?(self.application.redirect_uri)
    end
  end
end
