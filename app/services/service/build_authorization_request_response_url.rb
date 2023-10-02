module Service
  class BuildAuthorizationRequestResponseUrl < Actor
    input :redirect_uri, type: String, allow_nil: false
    input :code, type: String, allow_nil: false
    input :scope, type: String, allow_nil: false
    input :state, type: String, allow_nil: false
    output :url

    def call
      self.url = format_url
    end

    private

    def format_url
      [host, query_parameters].join('?')
    end

    def host
      self.redirect_uri
    end

    def query_parameters
      [query_code, query_scope, query_state].join('&')
    end

    def query_code
      "code=#{self.code}"
    end

    def query_scope
      "scope=#{self.scope}"
    end

    def query_state
      "state=#{self.state}"
    end
  end
end
