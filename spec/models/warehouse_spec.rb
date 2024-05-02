require 'rails_helper'

describe Warehouse do
  context '.all' do
    it 'returns all warehouses' do
      # Arrange
      json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
      fake_response = double('faraday_response', status: 200, body: json_data)
      allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses').and_return(fake_response)

      # Act
      result = Warehouse.all

      # Assert
      expect(result.length).to eq 2
      expect(result.first.id).to eq 1
      expect(result.first.name).to eq 'Aeroporto SP'
      expect(result.first.code).to eq 'GRU'
      expect(result.first.city).to eq 'Guarulhos'
      expect(result.first.area).to eq 100_000
      expect(result.first.address).to eq 'Avenida do Aeroporto, 1000'
      expect(result.first.cep).to eq '15000-000'
      expect(result.first.description).to eq 'Galpão destinado para cargas internacionais'
      expect(result.last.id).to eq 2
      expect(result.last.name).to eq 'Rio'
      expect(result.last.code).to eq 'SDU'
      expect(result.last.city).to eq 'Rio de Janeiro'
      expect(result.last.area).to eq 60_000
      expect(result.last.address).to eq 'Av do Porto, 1000'
      expect(result.last.cep).to eq '20000-000'
      expect(result.last.description).to eq 'Galpão do Rio'
    end
  end
end
