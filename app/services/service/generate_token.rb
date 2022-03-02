module Service
  class GenerateToken < Base

    def call
      begin
        secure = SecureRandom.method(context.generator_method)
        context.token = secure.call(context.length)
      rescue StandardError => e
        context.fail(error: e.message)
      end

      context
    end
  end
end
