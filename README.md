# README

In order to run the application a `.env.local` file is **required** in the root directory. This needs to contain the following

```
API_URL=https://www.googleapis.com/geolocation/v1/geolocate?key=
SECRET_KEY=google_api_key
CACHE_THRESHOLD=0.8 
API_KEY=#desired_api_key
```
When the app is run requests can be made to it using the following structure

```
curl --request POST \
  --url http://localhost:3000/geolocate \
  --header 'Content-Type: application/json' \
  --data '  {
    "api_key": "secret_key",
    "apscan_data": [
      {
        "band": "2.4",
        "bssid": "9c:b2:b2:66:c1:be",
        "channel": "5",
        "frequency": 2432,
        "rates": "1.0 - 135.0 Mbps",
        "rssi": -35,
        "security": "wpa-psk",
        "ssid": "HUAWEI-B315-C1BE",
        "timestamp": 1522886457.0,
        "vendor": "HUAWEI TECHNOLOGIES CO.,LTD",
        "width": "20"
      }
    ]
  }'
  ```
## Cache Threshold

The cache threshold represents the ratio of the number of AP presents in both sets of AP data divided by the number of unique APs in both. If this threshold is exceeded then the cache is used. Otherwise the google API is called.

*threshold = (matching)/(unique)*

## Running the app
### Running with ruby
In the root folder of the app run
```
gem install bundler
bundle install
```
to run the app run
```
rails s
```
### Running with docker-compose
In the root folder of the app run
```
docker-compose build
```
to run the app run
```
docker-compose run --service-ports geolocate
```
## Running the specs
### Running with bundler
In the root folder of the app run
```
gem install bundler
bundle install
```
to run the specs run
```
bundle exec rspec -fd spec
```
### Running with docker-compose
In the root folder of the app run
```
docker-compose build
```
to run the specs
```
docker-compose run geolocate_spec
```

## TODOS
- [x] Load secrets from env variables
- [x] auth
- [x] auth specs
- [x] dockerize
- [x] update readme
    * running tests
    * running app
- [x] CI
- [ ] error handling
- [ ] input validation
- [ ] Logging
- [ ] Monitoring