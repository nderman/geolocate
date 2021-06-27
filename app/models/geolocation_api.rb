# frozen_string_literal: true
require 'faraday'

class GeolocationApi

  def initialize
    @url = "https://www.googleapis.com/geolocation/v1/geolocate?key="
    @key = "secret" #TODO: move to env variable
  end

  def geolocate(scan_data)
    response = Faraday.post(@url+@key, parse_scan(scan_data).to_json, "Content-Type" => "application/json")
    response.body
  end

  private

  def parse_scan(scan_data)
    access_points = []
    scan_data.each do |scan|
      access_point = {}
      access_point["macAddress"] = scan["bssid"]
      access_point["channel"] = scan["channel"]
      access_point["signalStrength"] = scan["rssi"]
      access_points << access_point
    end
    ap_data = {}
    ap_data["wifiAccessPoints"] = access_points
    ap_data
  end
end
