# frozen_string_literal: true

module Service
  module Error
    class InvalidResponseType < Service::Failure
      STATUS = 400
      TYPE = :invalid_response_type

      def status
        STATUS
      end

      def type
        TYPE
      end

      def message
        "Invalid response_type: #{context.response_type}"
      end

      alias code status
    end
  end
end
