module Service
  class ValidateAuthorizationRequest < Actor
    play ValidateParameter, ValidateClient, ValidateRedirectUri, ValidateResponseType, ValidateScope
  end
end
