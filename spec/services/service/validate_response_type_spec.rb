# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service::ValidateResponseType, type: :model do
  let(:app) { create(:application) }
  let(:context) { Service::ValidateResponseType.call(params) }

  describe '.call' do
    context 'when response_type is valid' do
      let(:params) { { response_type: 'code' } }

      it 'return context with success' do
        expect(context.success?).to be true
      end

      it 'return valid_response_type with true' do
        expect(context.response_type_valid).to be true
      end
    end

    context 'when response_type is invalid' do
      let(:params) { { response_type: 'code1' } }

      it 'return context with failure' do
        expect(context.failure?).to be true
      end

      it 'return valid_response_type with true' do
        expect(context.response_type_valid).to be false
      end
    end

    context 'when parameter response_type is empty' do
      let(:params) { { app:, response_type: '' } }

      it 'return context failure' do
        expect(context.failure?).to be true
      end

      it 'return message with error "Missing required parameter: response_type"' do
        expect(context.message).to eq 'Missing required parameter: response_type'
      end

      it 'return status with 400' do
        expect(context.status).to eq 400
      end

      it 'return type with :invalid_request' do
        expect(context.type).to eq :invalid_request
      end

      it 'return response_type_valid with false' do
        expect(context.response_type_valid).to eq false
      end
    end

    context 'when parameter response_type is nil' do
      let(:params) { { app:, response_type: nil } }

      it 'return context failure' do
        expect(context.failure?).to be true
      end

      it 'return message with error "Missing required parameter: response_type"' do
        expect(context.message).to eq 'Missing required parameter: response_type'
      end

      it 'return status with 400' do
        expect(context.status).to eq 400
      end

      it 'return type with :invalid_request' do
        expect(context.type).to eq :invalid_request
      end

      it 'return response_type_valid with false' do
        expect(context.response_type_valid).to eq false
      end
    end
  end
end
