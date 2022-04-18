module Service
  module Error
    class InvalidClient < Service::Failure
      STATUS = 401
      TYPE = :invalid_client

      def status
        STATUS
      end

      def type
        TYPE
      end

      def message
        'The OAuth client was not found.'
      end

      alias code status
    end
  end
end
