# frozen_string_literal: true
require "rails_helper"

RSpec.describe(GeolocationApi) do
  describe "#geolocate" do
    context "When making a successful call to google geolocate with valid input data" do 
      it "parses the input data into correct form" do
        
      end
    end
  end
  describe "#parse_scan" do
    context "When receiving valid input data" do
      let(:scan_data) do
        TestData.scan_data
      end
      let(:ap_data) do
        TestData.ap_data
      end

      it "parses the data to correct request format" do
        expect(described_class.new.parse_scan(scan_data).to eq(ap_data))
      end
    end
  end
end
