# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service::ValidateResponseType, type: :model do
  let(:app) { create(:application) }

  describe '.call' do
    context 'when response_type is valid' do
      let(:params) { { response_type: 'code' } }

      it 'return context with success' do
        context = Service::ValidateResponseType.call(params)
        expect(context.success?).to be true
      end
    end

    context 'when response_type is invalid' do
      let(:params) { { response_type: 'code1' } }

      it 'return context with failure' do
        message = I18n.t('services.errors.invalid_response_type', response_type: params[:response_type])
        binding.pry
        expect { Service::ValidateResponseType.call(params) }.to raise_error(ServiceActor::Failure, message)
      end
    end
  end
end
