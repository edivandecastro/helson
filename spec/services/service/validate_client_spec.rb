# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service::ValidateClient, type: :model do
  describe '.call' do
    context 'when client was not found' do
      it 'return context failure' do
        context = Service::ValidateClient.call(client_id: 1)
        expect(context.failure?).to be true
      end

      it 'return message with error' do
        context = Service::ValidateClient.call(client_id: 1)
        expect(context.message).to eq 'The OAuth client was not found.'
      end

      it 'return status with 401' do
        context = Service::ValidateClient.call(client_id: 1)
        expect(context.status).to eq 401
      end

      it 'return type with :invalid_client' do
        context = Service::ValidateClient.call(client_id: 1)
        expect(context.type).to eq :invalid_client
      end

      it 'return client_valid with false' do
        context = Service::ValidateClient.call(client_id: 1)
        expect(context.client_valid).to eq false
      end
    end

    context 'when client was found' do
      let(:application) { create(:application) }

      it 'return context success' do
        context = Service::ValidateClient.call(client_id: application.client_id)
        expect(context.success?).to be true
      end

      it 'client_valid is true' do
        context = Service::ValidateClient.call(client_id: application.client_id)
        expect(context.client_valid).to be true
      end
    end
  end
end
