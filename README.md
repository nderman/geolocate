# README

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
- [ ] CI
- [ ] error handling
- [ ] "sad day" tests
