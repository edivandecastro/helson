require 'rails_helper'

RSpec.describe Oauth::AccessToken, type: :model do
  it "Factory" do
    expect(FactoryBot.create(:access_token)).to be_valid
  end

  context "Columns" do
    it { is_expected.to have_db_column(:token).of_type(:string) }
    it { is_expected.to have_db_column(:refresh_token).of_type(:string) }
    it { is_expected.to have_db_column(:expires_in).of_type(:integer) }
    it { is_expected.to have_db_column(:revoked_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:scopes).of_type(:string) }
    it { is_expected.to have_db_column(:user_id).of_type(:uuid) }
    it { is_expected.to have_db_column(:application_id).of_type(:uuid) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
    it { is_expected.to have_db_index(:application_id) }
    it { is_expected.to have_db_index(:user_id) }
    it { is_expected.to have_db_index(:token) }
    it { is_expected.to have_db_index(:refresh_token) }
  end

  context "Association" do
    it { is_expected.to belong_to(:user).required(true) }
    it { is_expected.to belong_to(:application).required(true) }
  end
end
