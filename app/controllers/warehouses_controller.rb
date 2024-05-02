class WarehousesController < ApplicationController
  def index
    @warehouses = Warehouse.all
  end

  def show
    id = params[:id]
    response = Faraday.get("http://localhost:3000/api/v1/warehouses/#{id}")
    return @warehouse = JSON.parse(response.body) if response.status == 200

    redirect_to root_path, notice: 'Não foi possível carregar o galpão'
  end
end
