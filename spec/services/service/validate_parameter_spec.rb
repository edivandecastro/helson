# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service::ValidateParameter, type: :model do
  describe '.call' do
    let(:context) { Service::ValidateParameter.call(params) }

    context 'when parameter client_id is nil' do
      let(:params) { { required_parameter: :client_id } }

      it 'return context failure' do
        expect(context.failure?).to be true
      end

      it 'return context with class Service::Error::MissingRequiredParameter' do
        expect(context.class_error).to eq Service::Error::MissingRequiredParameter
      end

      it 'return context with status 400' do
        expect(context.status).to eq 400
      end

      it 'return context with message "Missing required parameter: client_id"' do
        expect(context.message).to eq 'Missing required parameter: client_id'
      end
    end

    context 'when parameter client_id is empty' do
      let(:params) { { required_parameter: :client_id, client_id: '' } }

      it 'return context failure' do
        expect(context.failure?).to be true
      end

      it 'return context with class Service::Error::MissingRequiredParameter' do
        expect(context.class_error).to eq Service::Error::MissingRequiredParameter
      end

      it 'return context with status 400' do
        expect(context.status).to eq 400
      end

      it 'return context with message "Missing required parameter: client_id"' do
        expect(context.message).to eq 'Missing required parameter: client_id'
      end
    end

    context 'when parameter client_id is present' do
      let(:params) { { required_parameter: :client_id, client_id: 'example' } }

      it 'return context success' do
        expect(context.success?).to be true
      end
    end
  end
end
