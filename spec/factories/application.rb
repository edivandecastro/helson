FactoryBot.define do
  factory :application, class: Auth::Application do
    name { Faker::Name.name }
    client_id { Faker::Internet.uuid }
    client_secret { Faker::Code.sin }
    redirect_uri { Faker::Internet.url(path: '/oauth/callback') }
    scopes { [Faker::Verb.base, Faker::Verb.base, Faker::Verb.base].join(" ") }
    user
  end
end
