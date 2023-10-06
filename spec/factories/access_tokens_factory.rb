FactoryBot.define do
  factory :access_token, class: Oauth::AccessToken do
    token { Faker::Crypto.sha1 }
    refresh_token { Faker::Crypto.sha1 }
    expires_in { Faker::Number.between(from: 100, to: 999) }
    revoked_at { Faker::Time.backward(days: 5) }
    scopes { [Faker::Verb.base, Faker::Verb.base, Faker::Verb.base].join(" ") }
    user
    application
  end
end
