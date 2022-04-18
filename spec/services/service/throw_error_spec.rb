# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service::ThrowError, type: :model do
  describe '.call' do
    let(:context) { Service::ThrowError.call(class_error: Service::Error::InvalidClient) }

    it 'return context with failure' do
      expect(context.failure?).to be true
    end

    it 'return context with type :invalid_client' do
      expect(context.type).to eq :invalid_client
    end

    it 'return context with status 401' do
      expect(context.status).to eq 401
    end

    it 'return context with message "The OAuth client was not found."' do
      expect(context.message).to eq "The OAuth client was not found."
    end
  end
end
