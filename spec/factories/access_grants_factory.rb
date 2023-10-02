FactoryBot.define do
  factory :access_grant, class: Oauth::AccessGrant do
    token { Faker::Crypto.sha1 }
    expires_in { Faker::Number.between(from: 100, to: 999) }
    redirect_uri { Faker::Internet.url(path: '/oauth/callback') }
    revoked_at { Faker::Time.backward(days: 5) }
    scopes { [Faker::Verb.base, Faker::Verb.base, Faker::Verb.base].join(" ") }
    user
    application
  end
end
