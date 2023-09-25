# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service::ValidateRedirectUri, type: :model do
  describe '.call' do
    let(:application) { create(:application) }
    let(:context) { Service::ValidateRedirectUri.call(params) }

    context 'when context have application' do
      let(:params) { { client_id: application.client_id, application:, redirect_uri: } }

      context 'when redirect_uri is valid' do
        let(:redirect_uri) { application.redirect_uri }

        it 'return context success' do
          expect(context.success?).to be true
        end
      end

      context 'when redirect_uri is invalid' do
        let(:redirect_uri) { 'invalid' }

        it 'raise error ServiceActor::Failure' do
          message = I18n.t('services.errors.redirect_uri_mismatch').join(' ')
          expect { Service::ValidateRedirectUri.call(params) }.to raise_error(ServiceActor::Failure, message)
        end
      end

      context 'when parameter redirect_uri is empty' do
        let(:params) { { client_id: application.client_id, application:, redirect_uri: '' } }

        it 'raise error ServiceActor::Failure' do
          message = I18n.t('services.errors.redirect_uri_mismatch').join(' ')
          expect { Service::ValidateRedirectUri.call(params) }.to raise_error(ServiceActor::Failure, message)
        end
      end
    end
  end
end
