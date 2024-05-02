class WarehousesController < ApplicationController
  def index
    response = Faraday.get('http://localhost:3000/api/v1/warehouses')
    @warehouses = JSON.parse(response.body)
  end
end
