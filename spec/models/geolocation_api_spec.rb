# frozen_string_literal: true
require "rails_helper"
require "webmock/rspec"

RSpec.describe(GeolocationApi) do
  # memory store is per process and therefore no conflicts in parallel tests
  let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }
  let(:cache) { Rails.cache }

  let(:api_url) { ENV["API_URL"] }
  let(:secret) { ENV["SECRET_KEY"] }

  before do
    allow(Rails).to(receive(:cache).and_return(memory_store))
    Rails.cache.clear
  end

  describe "#geolocate" do
    context "When making a successful call to google geolocate with valid input data" do
      let(:scan_data) do
        TestData.scan_data
      end
      let(:ap_data) do
        TestData.ap_data
      end
      let(:location) do
        TestData.location
      end

      it "calls api with parsed data" do
        stub = stub_request(:post, api_url + secret)
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
        described_class.new.geolocate(scan_data["apscan_data"])
        expect(stub).to(have_been_requested)
      end
    end

    context "With similar access point data" do
      let(:scan_data) do
        {
          "apscan_data" => [
            {
              "bssid" => "one",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "two",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "three",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "four",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "five",
              "channel" => "5",
              "rssi" => "-35",
            },
          ],
        }
      end
      let(:scan_data_similar) do
        {
          "apscan_data" => [
            {
              "bssid" => "one",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "two",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "four",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "five",
              "channel" => "5",
              "rssi" => "-35",
            },
          ],
        }
      end
      let(:scan_data_similar_2) do
        {
          "apscan_data" => [
            {
              "bssid" => "one",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "two",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "three",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "four",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "five",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "six",
              "channel" => "5",
              "rssi" => "-35",
            },
          ],
        }
      end
      let(:scan_data_similar_3) do
        {
          "apscan_data" => [
            {
              "bssid" => "one",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "two",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "three",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "not_four",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "five",
              "channel" => "5",
              "rssi" => "-35",
            },
          ],
        }
      end
      let(:ap_data) do
        {
          "wifiAccessPoints" => [
            {
              "macAddress" => "one",
              "channel" => "5",
              "signalStrength" => "-35",
            },
            {
              "macAddress" => "two",
              "channel" => "5",
              "signalStrength" => "-35",
            },
            {
              "macAddress" => "three",
              "channel" => "5",
              "signalStrength" => "-35",
            },
            {
              "macAddress" => "four",
              "channel" => "5",
              "signalStrength" => "-35",
            },
            {
              "macAddress" => "five",
              "channel" => "5",
              "signalStrength" => "-35",
            },
          ],
        }
      end

      it "calls the cache instead of API when missing APs, but threshold (0.8 for test) is met" do
        stub_request(:post, api_url + secret)
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
        described_class.new.geolocate(scan_data["apscan_data"])
        expect(Rails.cache).to(receive(:read)).with("one,two,three,four,five")
        described_class.new.geolocate(scan_data_similar["apscan_data"])
      end

      it "calls the cache instead of API when additional APs, but threshold (0.8 for test) is met" do
        stub_request(:post, api_url + secret)
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
        described_class.new.geolocate(scan_data["apscan_data"])
        expect(Rails.cache).to(receive(:read)).with("one,two,three,four,five")
        described_class.new.geolocate(scan_data_similar_2["apscan_data"])
      end

      it "calls the cache instead of API when additional APs, but threshold (0.8 for test) is met" do
        stub_request(:post, api_url + secret)
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
        described_class.new.geolocate(scan_data["apscan_data"])
        expect(Rails.cache).to(receive(:read)).with("one,two,three,four,five")
        described_class.new.geolocate(scan_data_similar_3["apscan_data"])
      end
    end

    context "With similar access point data that doesn't meet threshold (0.8 for test)" do
      let(:scan_data) do
        {
          "apscan_data" => [
            {
              "bssid" => "one",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "two",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "three",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "four",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "five",
              "channel" => "5",
              "rssi" => "-35",
            },
          ],
        }
      end
      let(:scan_data_similar) do
        {
          "apscan_data" => [
            {
              "bssid" => "one",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "two",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "not_three",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "not_four",
              "channel" => "5",
              "rssi" => "-35",
            },
            {
              "bssid" => "five",
              "channel" => "5",
              "rssi" => "-35",
            },
          ],
        }
      end
      let(:ap_data) do
        {
          "wifiAccessPoints" => [
            {
              "macAddress" => "one",
              "channel" => "5",
              "signalStrength" => "-35",
            },
            {
              "macAddress" => "two",
              "channel" => "5",
              "signalStrength" => "-35",
            },
            {
              "macAddress" => "three",
              "channel" => "5",
              "signalStrength" => "-35",
            },
            {
              "macAddress" => "four",
              "channel" => "5",
              "signalStrength" => "-35",
            },
            {
              "macAddress" => "five",
              "channel" => "5",
              "signalStrength" => "-35",
            },
          ],
        }
      end
      let(:ap_data_2) do
        {
          "wifiAccessPoints" => [
            {
              "macAddress" => "one",
              "channel" => "5",
              "signalStrength" => "-35",
            },
            {
              "macAddress" => "two",
              "channel" => "5",
              "signalStrength" => "-35",
            },
            {
              "macAddress" => "not_three",
              "channel" => "5",
              "signalStrength" => "-35",
            },
            {
              "macAddress" => "not_four",
              "channel" => "5",
              "signalStrength" => "-35",
            },
            {
              "macAddress" => "five",
              "channel" => "5",
              "signalStrength" => "-35",
            },
          ],
        }
      end

      it "calls the API when cache threshold (0.8 for test) not met" do
        stub_request(:post, api_url + secret)
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
        stub2 = stub_request(:post, api_url + secret)
          .with(
            headers: {
              "Content-Type" => "application/json",
            },
            body: ap_data_2.to_json
          )
          .to_return(
            status: 200,
            body: location.to_json
          )
        described_class.new.geolocate(scan_data["apscan_data"])
        described_class.new.geolocate(scan_data_similar["apscan_data"])
        expect(stub2).to(have_been_requested)
      end
    end
  end
end
