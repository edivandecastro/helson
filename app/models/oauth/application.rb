module Oauth
  class Application < ApplicationRecord
    belongs_to :user
  end
end
