# frozen_string_literal: true

module Service
  class ValidateClient < Actor
    input :client_id, type: String, allow_nil: false
    output :application

    def call
      self.application = Application.find_by(client_id: client_id)
      fail!(error: I18n.t('services.errors.client_not_found')) if application.nil?
    end
  end
end
