FactoryBot.define do
  factory :application do
    name { Faker::Name.name }
    client_id { Faker::Internet.uuid }
    client_secret { Faker::Code.sin }
    redirect_uri { Faker::Internet.url(host: 'example.com', path: '/oauth/callback') }
    scopes { "#{Faker::Hobby.activity} #{Faker::Team.state}" }
    owner_id { Faker::Internet.uuid }
    owner_type { "User" }
  end
end
