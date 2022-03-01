json.extract! application, :id, :name, :client_id, :client_secret, :redirect_uri, :scopes, :created_at, :updated_at
json.url application_url(application, format: :json)
