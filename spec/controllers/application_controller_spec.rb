require "rails_helper"

RSpec.describe(ApplicationController, type: :controller) do
     
    
# define anonymous controller inheriting from application controller
    controller do
        def index
            render :text => "something"
        end
    end

    context 'with valid API key' do
        let (:api_key) {ENV["API_KEY"]}

        it "allows call to member functions" do
            post :index, params: {"api_key" => api_key}
            expect(response.status).to(eq(200))
        end
    end

    context 'with invalid API key' do
        let (:api_key) {"cheese"}
        
        it "Returns status 401" do
            post :index, params: {"api_key" => api_key}
            expect(response.status).to(eq(401))
        end
    end

    context 'with no API key paramater' do
        it "Returns status 401" do
            post :index
            expect(response.status).to(eq(401))
        end
    end


end