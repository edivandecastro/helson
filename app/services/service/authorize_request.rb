module Service
  class AuthorizeRequest < Actor
    play ValidateAuthorizationRequest, CreateAccessGrant, BuildAuthorizationRequestResponseUrl
  end
end
