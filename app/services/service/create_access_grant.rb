module Service
  class CreateAccessGrant < Actor
    input :application
    input :user
    output :access_grant
    output :code
    output :scope

    def call
      self.access_grant = Oauth::AccessGrant.new
      self.code = Service::GenerateToken.call.token
      self.access_grant.token = self.code
      self.access_grant.expires_in = 300
      self.access_grant.redirect_uri = self.result.redirect_uri
      self.access_grant.scopes = self.result.scopes
      self.scope = self.result.scopes
      self.access_grant.application = self.application
      self.access_grant.user = self.user

      return if self.access_grant.save

      fail!(error: "deu um erro ao gerar o acesso!")
    end
  end
end
