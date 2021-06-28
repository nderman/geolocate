# frozen_string_literal: true

require "rails_helper"
require "webmock/rspec"

RSpec.describe("/geolocate", type: :request) do
    before(:each) do
      allow_any_instance_of(ApplicationController).to(receive(:require_api_key).and_return(true))
    end
  # memory store is per process and therefore no conflicts in parallel tests
  let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }
  let(:cache) { Rails.cache }

  before do
    allow(Rails).to(receive(:cache).and_return(memory_store))
    Rails.cache.clear
  end

  describe "Call to /geolocate" do
    context "when making a successful call to geolocate" do
      let(:scan_data) do
        TestData.scan_data
      end
      let(:ap_data) do
        TestData.ap_data
      end
      let(:location) do
        TestData.location
      end

      def geolocate(query)
        stub_request(:post, "https://www.googleapis.com/geolocation/v1/geolocate?key=secret")
          .with(
            headers: {
              "Content-Type" => "application/json",
            },
            body: ap_data.to_json
          )
          .to_return(
            status: 200,
            body: location.to_json
          )
        post("/geolocate", params: query)
      end
      before do
        geolocate(scan_data)
      end

      it "returns a status 200" do
        expect(response).to(have_http_status(:ok))
      end

      it "returns location data for the query" do
        expect(response.body).to(eql(location.to_json))
      end
    end
  end
end
