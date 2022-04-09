# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service::ValidateResponseType, type: :model do
  let(:app) { create(:application) }
  let(:context) { Service::ValidateResponseType.call(params) }

  describe '.call' do
    context 'when response_type is not invalid' do
      let(:params) { { response_type: 'code' } }

      it 'return context with success' do
        expect(context.success?).to be true
      end

      it 'return validate_response_type with true' do
        expect(context.validate_response_type).to be true
      end
    end

    context 'when response_type is invalid' do
      let(:params) { { response_type: '' } }

      it 'return context with failure' do
        expect(context.failure?).to be true
      end

      it 'return validate_response_type with true' do
        expect(context.validate_response_type).to be false
      end
    end
  end
end
