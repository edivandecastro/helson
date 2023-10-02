class AuthorizationsController < ApplicationController
  before_action :authenticate_user!

  def new
    # http://localhost:3000/oauth/authorize?client_id=849af7c8-6fd6-4e08-83a8-278262a64578&redirect_uri=http://localhost:3000/oauth/callback&response_type=code&scope=sag invent cheer&state=test
    result = Service::ValidateAuthorizationRequest.call(client_id: params[:client_id],
                                                        redirect_uri: params[:redirect_uri],
                                                        response_type: params[:response_type],
                                                        scopes: params[:scope],
                                                        state: params[:state],
                                                        user: current_user)
  rescue ServiceActor::Failure => e
    @error = e.message
  end

  def create
    result = Service::AuthorizeRequest.call(client_id: params[:client_id],
                                            redirect_uri: params[:redirect_uri],
                                            response_type: params[:response_type],
                                            scopes: params[:scope],
                                            state: params[:state],
                                            user: current_user)

    redirect_to result.url

  rescue ServiceActor::Failure => e
    @error = e.message
  end

  def destroy
  end

  def callback
    binding.pry
  end
end
