# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service::ValidateScope, type: :model do
  describe '.call' do
    let(:app) { create(:application, scopes: 'email profile rules') }
    let(:context) { Service::ValidateScope.call(params) }

    context 'when context have app' do
      let(:params) { { client_id: app.client_id, app:, scopes: } }

      context 'when scopes is valid' do
        let(:scopes) { 'email profile rules' }

        it 'return context success' do
          expect(context.success?).to be true
        end

        it 'return validate_scopes with true' do
          expect(context.validate_scopes).to be true
        end
      end

      context 'when scopes is invalid' do
        let(:scopes) { 'openid email profile rules' }

        it 'return context failure' do
          expect(context.failure?).to be true
        end

        it 'return validate_scopes with false' do
          expect(context.validate_scopes).to be false
        end
      end
    end

    context 'when context not have app' do
      let(:params) { { client_id: app.client_id, scopes: } }

      context 'when scopes is valid' do
        let(:scopes) { 'email profile rules' }

        it 'return context success' do
          expect(context.success?).to be true
        end

        it 'return validate_scopes with true' do
          expect(context.validate_scopes).to be true
        end
      end

      context 'when scopes is invalid' do
        let(:scopes) { 'openid email profile rules' }

        it 'return context failure' do
          expect(context.failure?).to be true
        end

        it 'return validate_scopes with false' do
          expect(context.validate_scopes).to be false
        end
      end
    end
  end
end
