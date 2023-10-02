# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service::AuthorizeRequest, type: :model do
  describe '.call' do
    context 'when all parameters is nil' do
      it 'raise error ServiceActor::Failure' do
        message = "Missing required parameter: client_id, redirect_uri, response_type, scopes"

        expect { Service::AuthorizeRequest.call(client_id: nil,
                                                 redirect_uri: nil,
                                                 response_type: nil,
                                                 scopes: nil,
                                                 state: nil) }.to raise_error(ServiceActor::Failure, message)
      end
    end

    context 'when all parameters is empty' do
      it 'raise error ServiceActor::Failure' do
        message = "Missing required parameter: client_id, redirect_uri, response_type, scopes"

        expect { Service::AuthorizeRequest.call(client_id: '',
                                                 redirect_uri: '',
                                                 response_type: '',
                                                 scopes: nil,
                                                 state: '') }.to raise_error(ServiceActor::Failure, message)
      end
    end

    context 'when all parameters is present' do
      let(:application) { create(:application) }
      let(:user) { create(:user) }

      it 'return context with success' do
        result = Service::AuthorizeRequest.call(client_id: application.client_id,
                                                redirect_uri: application.redirect_uri,
                                                response_type: 'code',
                                                scopes: application.scopes,
                                                state: nil,
                                                user:)

        expect(result.success?).to be true
      end
    end
  end
end
