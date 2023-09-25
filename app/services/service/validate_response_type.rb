# frozen_string_literal: true

module Service
  class ValidateResponseType < Actor
    input :response_type, type: String

    def call
      return if self.response_type == 'code'

      fail!(error: I18n.t('services.errors.invalid_response_type', response_type: self.response_type))
    end
  end
end
