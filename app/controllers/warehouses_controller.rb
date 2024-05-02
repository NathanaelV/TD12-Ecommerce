class WarehousesController < ApplicationController
  def index
    @warehouses = []
    response = Faraday.get('http://localhost:3000/api/v1/warehouses')
    @data = response.body
  end
end
