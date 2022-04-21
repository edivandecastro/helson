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

        it 'return scopes_valid with true' do
          expect(context.scopes_valid).to be true
        end
      end

      context 'when scopes is invalid' do
        let(:scopes) { 'openid email profile rules' }

        it 'return context failure' do
          expect(context.failure?).to be true
        end

        it 'return scopes_valid with false' do
          expect(context.scopes_valid).to be false
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

        it 'return scopes_valid with true' do
          expect(context.scopes_valid).to be true
        end
      end

      context 'when scopes is invalid' do
        let(:scopes) { 'openid email profile rules' }

        it 'return context failure' do
          expect(context.failure?).to be true
        end

        it 'return scopes_valid with false' do
          expect(context.scopes_valid).to be false
        end

        it 'return message with error "Some requested scopes were invalid."' do
          expect(context.message).to include 'Some requested scopes were invalid.'
        end
      end

      context 'when parameter scopes is empty' do
        let(:params) { { app:, scopes: '' } }

        it 'return context failure' do
          expect(context.failure?).to be true
        end

        it 'return message with error "Missing required parameter: scopes"' do
          expect(context.message).to eq 'Missing required parameter: scopes'
        end

        it 'return status with 400' do
          expect(context.status).to eq 400
        end

        it 'return type with :invalid_request' do
          expect(context.type).to eq :invalid_request
        end

        it 'return scope_valid with false' do
          expect(context.scopes_valid).to eq false
        end
      end
    end
  end
end
