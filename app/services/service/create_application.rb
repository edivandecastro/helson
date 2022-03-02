module Service
  class CreateApplication < Base

    def call
      begin
        context.application = Application.new(context.params)
        add_owner
        generate_token
        context.application.save
      rescue StandardError => e
        context.fail(error: e.message)
      end

      context
    end

    private
      def add_owner
        context.application.owner_id = context.user.id
        context.application.owner_type = context.user.class.name
      end

      def generate_token
        client_id = Service::GenerateToken.call(generator_method: :hex, length: 24).token
        client_secret = Service::GenerateToken.call(generator_method: :hex, length: 32).token

        context.application.client_id = client_id
        context.application.client_secret = client_secret
      end
  end
end
