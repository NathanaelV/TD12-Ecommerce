class Warehouse
  attr_accessor :id, :name, :code, :city, :area, :address, :cep, :description

  def initialize(id:, name:, code:, city:, area:, address:, cep:, description:)
    @id = id
    @name = name
    @code = code
    @city = city
    @area = area
    @address = address
    @cep = cep
    @description = description
  end

  def self.all
    warehouses = []
    response = Faraday.get('http://localhost:3000/api/v1/warehouses')
    data = JSON.parse(response.body)
    data.each do |d|
      warehouses << Warehouse.new(id: d['id'], name: d['name'], code: d['code'], city: d['city'], area: d['area'],
                                  address: d['address'], cep: d['cep'], description: d['description'])
    end
    warehouses
  end
end
