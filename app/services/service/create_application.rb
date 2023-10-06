module Service
  class CreateApplication < Actor
    input :params
    input :user
    output :application

    def call
      self.application = Application.new(self.params)
      self.application.user = self.user
      self.application.client_id = Service::GenerateToken.call.token
      self.application.client_secret = Service::GenerateToken.call(length: 32).token
      self.application.save
    rescue StandardError => e
      fail!(error: e.message)
    end
  end
end
