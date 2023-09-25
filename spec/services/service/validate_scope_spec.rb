# frozen_string_literal: true

require "rails_helper"

RSpec.describe Service::ValidateScope, type: :model do
  describe ".call" do
    let(:application) { create(:application, scopes: "email profile rules") }
    let(:context) { Service::ValidateScope.call(params) }

    context "when context have app" do
      let(:params) { { application:, scopes: } }

      context "when scopes is valid" do
        let(:scopes) { "email profile rules" }

        it "return context success" do
          context = Service::ValidateScope.call(params)
          expect(context.success?).to be true
        end
      end

      context "when scopes is invalid" do
        let(:scopes) { "openid email profile rules" }

        it "return context failure" do
          message = I18n.t("services.errors.invalid_scope",
                           scope_valid: "email, profile, rules",
                           scope_invalid: "openid")

          expect { Service::ValidateScope.call(params) }.to raise_error(ServiceActor::Failure, message)
        end
      end
    end
  end
end
