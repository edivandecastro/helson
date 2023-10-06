module Oauth
  class AccessToken < ApplicationRecord
    belongs_to :user
    belongs_to :application
  end
end
