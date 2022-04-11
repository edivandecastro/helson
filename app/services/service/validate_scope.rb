# frozen_string_literal: true

module Service
  class ValidateScope < Base
    def call
      app = context.app || Application.find_by(client_id: context.client_id)
      valid, invalid = separate_scopes(scopes: app.scopes.split)
      context.validate_scopes = invalid.empty?
      context.fail(error(valid, invalid)) if invalid.any?
      context
    end

    private

    def error(valid, invalid)
      {
        statu: 400,
        type: :invalid_scope,
        message: 'Some requested scopes were invalid.' \
                 "{valid=[#{valid.join(', ')}], invalid=[#{invalid.join(', ')}]}",
      }
    end

    def separate_scopes(scopes:)
      valid = []
      invalid = []

      context.scopes.split.each do |scope|
        if scopes.include?(scope)
          valid.push(scope)
        else
          invalid.push(scope)
        end
      end

      [valid, invalid]
    end
  end
end
