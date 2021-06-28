# frozen_string_literal: true
class ApplicationController < ActionController::API
  before_action :require_api_key

  private

  def require_api_key
    render(json: { error: "Not Authorized" }, status: 401) unless params["api_key"] == ENV["API_KEY"]
  end
end
