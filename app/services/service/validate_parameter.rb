# frozen_string_literal: true

module Service
  class ValidateParameter < Actor
    input :client_id
    input :redirect_uri
    input :response_type
    input :scopes
    input :state, allow_nil: true

    def call
      return if input_invalid.empty?

      fail!(error: I18n.t('services.errors.missing_required_parameter', params: input_invalid.join(', ')))
    end

    private

    def input_invalid
      inputs.map { |k, v| k if v.nil? || v.empty? }.compact
    end

    def inputs
      {
        client_id:,
        redirect_uri:,
        response_type:,
        scopes:
      }
    end
  end
end
