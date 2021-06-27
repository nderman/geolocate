Rails.application.routes.draw do
  post "/geolocate", to: "geolocate#locate"
end
