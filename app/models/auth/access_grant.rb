module Auth
  class AccessGrant < ApplicationRecord
    belongs_to :user
    belongs_to :application
  end
end
