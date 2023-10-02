module Service
  class GenerateToken < Actor
    input :generator_method, null: false, default: :hex
    input :length, null: false, default: 24
    output :token

    def call
      secure = SecureRandom.method(self.generator_method)
      self.token = secure.call(self.length)
    rescue StandardError => e
      fail!(error: e.message)
    end
  end
end
