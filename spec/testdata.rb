# frozen_string_literal: true
# frozen_string_literal=>true
module TestData
  def scan_data
    {
      "apscan_data" => [
        {
          "band" => "2.4",
          "bssid" => "9c:b2:b2:66:c1:be",
          "channel" => "5",
          "frequency" => "2432",
          "rates" => "1.0 - 135.0 Mbps",
          "rssi" => "-35",
          "security" => "wpa-psk",
          "ssid" => "HUAWEI-B315-C1BE",
          "timestamp" => "1_522_886_457.0",
          "vendor" => "HUAWEI TECHNOLOGIES CO.,LTD",
          "width" => "20",
        },
        {
          "band" => "2.4",
          "bssid" => "84:78:ac:b9:76:19",
          "channel" => "1",
          "frequency" => "2412",
          "rates" => "6.5 - 270.0 Mbps",
          "rssi" => "-56",
          "security" => "wpa-eap",
          "ssid" => "1 Telkom Connect",
          "timestamp" => "1_522_886_457.0",
          "vendor" => "Cisco Systems, Inc",
          "width" => "20",
        },
        {
          "band" => "2.4",
          "bssid" => "c0:a0:bb:c4:10:d6",
          "channel" => "1",
          "frequency" => "2412",
          "rates" => "1.0 - 54.0 Mbps",
          "rssi" => "-66",
          "security" => "wpa-psk",
          "ssid" => "default",
          "timestamp" => "1_522_886_457.0",
          "vendor" => "D-Link International",
          "width" => "40",
        },
        {
          "band" => "5.0",
          "bssid" => "84:78:ac:b9:76:16",
          "channel" => "56",
          "frequency" => "5280",
          "rates" => "6.5 - 270.0 Mbps",
          "rssi" => "-82",
          "security" => "wpa-eap",
          "ssid" => "1 Telkom Connect",
          "timestamp" => "1_522_886_457.0",
          "vendor" => "Cisco Systems, Inc",
          "width" => "20",
        },
        {
          "band" => "5.0",
          "bssid" => "e8:1d:a8:28:a6:6c",
          "channel" => "36",
          "frequency" => "5180",
          "rates" => "6.0 - 866.7 Mbps",
          "rssi" => "-65",
          "security" => "open",
          "ssid" => "@VAST",
          "timestamp" => "1_522_886_457.0",
          "vendor" => "Ruckus Wireless",
          "width" => "80",
        },
        {
          "band" => "2.4",
          "bssid" => "e8:1d:a8:28:a6:68",
          "channel" => "8",
          "frequency" => "2447",
          "rates" => "6.0 - 135.0 Mbps",
          "rssi" => "-52",
          "security" => "open",
          "ssid" => "@VAST",
          "timestamp" => "1_522_886_457.0",
          "vendor" => "Ruckus Wireless",
          "width" => "20",
        },
        {
          "band" => "2.4",
          "bssid" => "e8:1d:a8:68:a6:68",
          "channel" => "8",
          "frequency" => "2447",
          "rates" => "6.0 - 135.0 Mbps",
          "rssi" => "-53",
          "security" => "open",
          "ssid" => "McDonalds@VAST",
          "timestamp" => "1_522_886_457.0",
          "vendor" => "Ruckus Wireless",
          "width" => "20",
        },
        {
          "band" => "2.4",
          "bssid" => "84:78:ac:b9:76:1a",
          "channel" => "1",
          "frequency" => "2412",
          "rates" => "6.5 - 270.0 Mbps",
          "rssi" => "-57",
          "security" => "open",
          "ssid" => "1 Telkom Guest",
          "timestamp" => "1_522_886_457.0",
          "vendor" => "Cisco Systems, Inc",
          "width" => "20",
        },
        {
          "band" => "5.0",
          "bssid" => "84:78:ac:b9:76:15",
          "channel" => "56",
          "frequency" => "5280",
          "rates" => "6.5 - 270.0 Mbps",
          "rssi" => "-82",
          "security" => "open",
          "ssid" => "1 Telkom Guest",
          "timestamp" => "1_522_886_457.0",
          "vendor" => "Cisco Systems, Inc",
          "width" => "20",
        },
        {
          "band" => "5.0",
          "bssid" => "e8:1d:a8:68:a6:6c",
          "channel" => "36",
          "frequency" => "5180",
          "rates" => "6.0 - 866.7 Mbps",
          "rssi" => "-66",
          "security" => "open",
          "ssid" => "McDonalds@VAST",
          "timestamp" => "1_522_886_457.0",
          "vendor" => "Ruckus Wireless",
          "width" => "80",
        },
      ],
    }
  end

  def ap_data
    {
      "wifiAccessPoints" => [
        {
          "macAddress" => "9c:b2:b2:66:c1:be",
          "channel" => "5",
          "signalStrength" => "-35",
        },
        {
          "macAddress" => "84:78:ac:b9:76:19",
          "channel" => "1",
          "signalStrength" => "-56",
        },
        {
          "macAddress" => "c0:a0:bb:c4:10:d6",
          "channel" => "1",
          "signalStrength" => "-66",
        },
        {
          "macAddress" => "84:78:ac:b9:76:16",
          "channel" => "56",
          "signalStrength" => "-82",
        },
        {
          "macAddress" => "e8:1d:a8:28:a6:6c",
          "channel" => "36",
          "signalStrength" => "-65",
        },
        {
          "macAddress" => "e8:1d:a8:28:a6:68",
          "channel" => "8",
          "signalStrength" => "-52",
        },
        {
          "macAddress" => "e8:1d:a8:68:a6:68",
          "channel" => "8",
          "signalStrength" => "-53",
        },
        {
          "macAddress" => "84:78:ac:b9:76:1a",
          "channel" => "1",
          "signalStrength" => "-57",
        },
        {
          "macAddress" => "84:78:ac:b9:76:15",
          "channel" => "56",
          "signalStrength" => "-82",
        },
        {
          "macAddress" => "e8:1d:a8:68:a6:6c",
          "channel" => "36",
          "signalStrength" => "-66",
        },
      ],
    }
  end

  def location
    {
      "location" => {
        "lat" => -33.9203129,
        "lng" => 25.5909409,
      },
      "accuracy" => 26,
    }
  end
end
