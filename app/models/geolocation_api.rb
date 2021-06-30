# frozen_string_literal: true
require "faraday"

class GeolocationApi
  def initialize
    @url = ENV["API_URL"]
    @key = ENV["SECRET_KEY"]
    @cache_threshold = ENV["CACHE_THRESHOLD"].to_f
  end

  def geolocate(scan_data)
    key_arr = key_arr(scan_data)
    cache_key = check_cache(key_arr, @cache_threshold)
    location = false

    if cache_key.present?
      location = Rails.cache.read(cache_key)
    else
      ap_data = parse_scan(scan_data)
      response = Faraday.post(@url + @key, ap_data.to_json, "Content-Type" => "application/json")
      if response.status == 200
        location = response.body
        Rails.cache.write(key_arr.join(","), location)
      end
    end
    location
  end

  private

  # creates an array of AP mac addresses from scan data
  def key_arr(scan_data)
    scan_data.map { |h| h["bssid"] }
  end

  # calculcates similarity between array and existing keys
  def check_cache(key_array, threshold)
    cache_keys = Rails.cache.instance_variable_get(:@data).keys
    key_match = nil
    cache_keys.each do |key|
      key_array_cache = key.split(",")
      diff = max((key_array_cache - key_array).count, (key_array - key_array_cache).count).to_f
      unique = (key_array_cache + key_array).uniq.count.to_f
      score = (unique - diff) / unique
      key_match = key if score >= threshold
      break key if score >= threshold # break loop on first match
    end
    key_match
  end

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

  def max(a, b)
    a > b ? a : b
  end
end
