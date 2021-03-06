# frozen_string_literal: true
require "rails_helper"

RSpec.describe(GeolocateController, type: :controller) do
  before do
    allow(controller).to(receive(:require_api_key).and_return(true))
  end

  describe "#locate" do
    before do
      @double_geolocation_api = double(GeolocationApi)
    end

    context "With valid, succesful call" do
      let(:scan_params) do
        TestData.scan_data
      end

      it "calls the GeolocationApi model with the scan data" do
        allow(GeolocationApi).to(receive(:new).and_return(@double_geolocation_api))
        expect(@double_geolocation_api).to(receive(:geolocate).with(scan_params["apscan_data"]))
        post :locate, params: scan_params
      end

      it "returns response status 200 on success" do
        allow(GeolocationApi).to(receive(:new).and_return(@double_geolocation_api))
        allow(@double_geolocation_api).to(receive(:geolocate).with(scan_params["apscan_data"]).and_return(TestData.location))
        post :locate, params: scan_params
        expect(response.status).to(eq(200))
      end

      it "returns the location on success for query" do
        allow(GeolocationApi).to(receive(:new).and_return(@double_geolocation_api))
        allow(@double_geolocation_api).to(receive(:geolocate).with(scan_params["apscan_data"]).and_return(TestData.location))
        post :locate, params: scan_params
        expect(response.body).to(eq(TestData.location.to_json))
      end
    end

    context "With failed call to google geolocate" do
      let(:scan_params) do
        TestData.scan_data
      end

      it "returns response status 200 on success" do
        allow(GeolocationApi).to(receive(:new).and_return(@double_geolocation_api))
        allow(@double_geolocation_api).to(receive(:geolocate).with(scan_params["apscan_data"])).and_return(false)
        post :locate, params: scan_params
        expect(response.status).to(eq(502))
      end

      it "returns the location on success for query" do
        allow(GeolocationApi).to(receive(:new).and_return(@double_geolocation_api))
        allow(@double_geolocation_api).to(receive(:geolocate).with(scan_params["apscan_data"]).and_return(false))
        post :locate, params: scan_params
        expect(response.body).to(eq("Upstream Error"))
      end
    end
  end
end
