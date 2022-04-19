# frozen_string_literal: true

module Service
  module Error
    class RedirectUriMismatch < Service::Failure
      STATUS = 400
      TYPE = :redirect_uri_mismatch

      def status
        STATUS
      end

      def type
        TYPE
      end

      def message
        'Unable to sign in to the app because it doesn\'t comply with OAuth 2.0 policy.' \
          'If you are the app developer, record the redirect URI in the your application.'
      end

      alias code status
    end
  end
end
