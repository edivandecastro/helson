module Oauth
  class Application < ApplicationRecord
    belongs_to :user
    has_many :access_grants
  end
end
