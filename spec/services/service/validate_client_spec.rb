# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service::ValidateClient, type: :model do
  let(:application) { build(:application) }

  describe '.call' do
    context 'when client was not found' do
      let(:context) { Service::ValidateClient.call(client_id: application.client_id) }

      it 'raise error ServiceActor::Failure' do
        message = I18n.t('services.errors.client_not_found')
        expect { Service::ValidateClient.call(client_id: application.client_id) }.to raise_error(ServiceActor::Failure, message)
      end
    end

    context 'when parameter client_id is empty' do
      it 'raise error ServiceActor::Failure' do
        message = I18n.t('services.errors.client_not_found')
        expect { Service::ValidateClient.call(client_id: application.client_id) }.to raise_error(ServiceActor::Failure, message)
      end
    end

    context 'when parameter client_id is nil' do
      it 'raise error ServiceActor::Failure' do
        message = I18n.t('services.errors.client_not_found')
        expect { Service::ValidateClient.call(client_id: application.client_id) }.to raise_error(ServiceActor::Failure, message)
      end
    end

    context 'when client was found' do
      let(:application) { create(:application) }

      it 'return context success' do
        context = Service::ValidateClient.call(client_id: application.client_id)
        expect(context.success?).to be true
      end

      it 'return context with application' do
        result = Service::ValidateClient.call(client_id: application.client_id)
        expect(result.application.id).to eq application.id
      end
    end
  end
end
