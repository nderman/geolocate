# frozen_string_literal: true
require "rails_helper"
require "webmock/rspec"

RSpec.describe(GeolocationApi) do
  describe "#geolocate" do
    context "When making a successful call to google geolocate with valid input data" do
      let(:scan_data) do
        TestData.scan_data
      end
      let(:ap_data) do
        TestData.ap_data
      end

      it "calls api with parsed data" do
        stub = stub_request(:post, "https://www.googleapis.com/geolocation/v1/geolocate?key=secret")
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
        GeolocationApi.new.geolocate(scan_data["apscan_data"])
        expect(stub).to have_been_requested
      end
    end
  end
end
