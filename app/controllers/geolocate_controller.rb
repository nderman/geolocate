# frozen_string_literal: true
class GeolocateController < ApplicationController
  def locate
    location = GeolocationApi.new.geolocate(apscan_params.to_h["apscan_data"])
    render(json: location, status: :ok)
  end

  private

  def apscan_params
    params.permit(apscan_data: [:band, :bssid, :channel, :frequency, :rates, :rssi, :security, :ssid, :timestamp,
                                :vendor, :width])
  end
end
