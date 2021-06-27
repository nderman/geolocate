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
        expect(a_request(:post, "www.example.com")
        .with(
          headers: {
            "Content-Type" => "application/json",
          },
          body: ap_data.to_json
        )).to(have_been_made.once)
      end
    end
  end
end
