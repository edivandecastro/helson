# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service::ValidateRedirectUri, type: :model do
  describe '.call' do
    let(:app) { create(:application) }
    let(:context) { Service::ValidateRedirectUri.call(params) }

    context 'when context have app' do
      let(:params) { { client_id: app.client_id, app:, redirect_uri: } }

      context 'when redirect_uri is valid' do
        let(:redirect_uri) { app.redirect_uri }

        it 'return context success' do
          expect(context.success?).to be true
        end

        it 'return validate_redirect_uri with true' do
          expect(context.redirect_uri_valid).to be true
        end
      end

      context 'when redirect_uri is invalid' do
        let(:redirect_uri) { 'invalid' }

        it 'return context failure' do
          expect(context.failure?).to be true
        end

        it 'return validate_redirect_uri with false' do
          expect(context.redirect_uri_valid).to be false
        end
      end

      context 'when parameter redirect_uri is empty' do
        let(:params) { { client_id: app.client_id, app:, redirect_uri: '' } }

        it 'return context failure' do
          expect(context.failure?).to be true
        end

        it 'return message with error "Missing required parameter: redirect_uri"' do
          expect(context.message).to eq 'Missing required parameter: redirect_uri'
        end

        it 'return status with 400' do
          expect(context.status).to eq 400
        end

        it 'return type with :invalid_request' do
          expect(context.type).to eq :invalid_request
        end

        it 'return redirect_uri_valid with false' do
          expect(context.redirect_uri_valid).to eq false
        end
      end

      context 'when parameter redirect_uri is nil' do
        let(:params) { { client_id: app.client_id, app:, redirect_uri: nil } }

        it 'return context failure' do
          expect(context.failure?).to be true
        end

        it 'return message with error "Missing required parameter: redirect_uri"' do
          expect(context.message).to eq 'Missing required parameter: redirect_uri'
        end

        it 'return status with 400' do
          expect(context.status).to eq 400
        end

        it 'return type with :invalid_request' do
          expect(context.type).to eq :invalid_request
        end

        it 'return redirect_uri_valid with false' do
          expect(context.redirect_uri_valid).to eq false
        end
      end
    end

    context 'when context not have app' do
      let(:params) { { client_id: app.client_id, redirect_uri: } }

      context 'when redirect_uri is valid' do
        let(:redirect_uri) { app.redirect_uri }

        it 'return context success' do
          expect(context.success?).to be true
        end

        it 'return validate_redirect_uri with true' do
          expect(context.redirect_uri_valid).to be true
        end
      end

      context 'when redirect_uri is invalid' do
        let(:redirect_uri) { 'invalid' }

        it 'return context failure' do
          expect(context.failure?).to be true
        end

        it 'return validate_redirect_uri with false' do
          expect(context.redirect_uri_valid).to be false
        end
      end
    end
  end
end
