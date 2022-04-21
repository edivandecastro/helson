# frozen_string_literal: true

module Service
  module Error
    class InvalidScope < Service::Failure
      STATUS = 400
      TYPE = :invalid_scope

      def status
        STATUS
      end

      def type
        TYPE
      end

      def message
        'Some requested scopes were invalid. ' \
          "{valid=[#{context.scope_valid.join(', ')}], " \
          "invalid=[#{context.scope_invalid.join(', ')}]}"
      end

      alias code status
    end
  end
end
