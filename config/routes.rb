Rails.application.routes.draw do
  post "/geolocate" => "geolocate#locate", :as => :geolocate
end
