# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service::ValidateClient, type: :model do
  describe '.call' do
    context 'when client was not found' do
      let(:context) { Service::ValidateClient.call(client_id: 1) }

      it 'return context failure' do
        expect(context.failure?).to be true
      end

      it 'return message with error' do
        expect(context.message).to eq 'The OAuth client was not found.'
      end

      it 'return status with 401' do
        expect(context.status).to eq 401
      end

      it 'return type with :invalid_client' do
        expect(context.type).to eq :invalid_client
      end

      it 'return client_valid with false' do
        expect(context.client_valid).to eq false
      end
    end

    context 'when parameter client_id is empty' do
      let(:context) { Service::ValidateClient.call(client_id: '') }

      it 'return context failure' do
        expect(context.failure?).to be true
      end

      it 'return message with error "Missing required parameter: client_id"' do
        expect(context.message).to eq 'Missing required parameter: client_id'
      end

      it 'return status with 400' do
        expect(context.status).to eq 400
      end

      it 'return type with :invalid_request' do
        expect(context.type).to eq :invalid_request
      end

      it 'return client_valid with false' do
        expect(context.client_valid).to eq false
      end
    end

    context 'when parameter client_id is nil' do
      let(:context) { Service::ValidateClient.call(client_id: nil) }

      it 'return context failure' do
        expect(context.failure?).to be true
      end

      it 'return message with error "Missing required parameter: client_id"' do
        expect(context.message).to eq 'Missing required parameter: client_id'
      end

      it 'return status with 400' do
        expect(context.status).to eq 400
      end

      it 'return type with :invalid_request' do
        expect(context.type).to eq :invalid_request
      end

      it 'return client_valid with false' do
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
