module Service
  module Error
    class MissingRequiredParameter < Service::Failure
      STATUS = 400
      TYPE = :invalid_request

      def status
        STATUS
      end

      def type
        TYPE
      end

      def message
        "Missing required parameter: #{context.required_parameter}"
      end

      alias code status
    end
  end
end
