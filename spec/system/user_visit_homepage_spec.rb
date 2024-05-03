require 'rails_helper'

describe 'User view homepage' do
  it 'views warehouses' do
    # Arrange
    warehouses = []
    warehouses << Warehouse.new(id: 1, name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                description: 'Galpão destinado para cargas internacionais')
    warehouses << Warehouse.new(id: 2, name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                address: 'Av do Porto, 1000', cep: '20000-000',
                                description: 'Galpão do Rio')
    allow(Warehouse).to receive(:all).and_return(warehouses)

    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'E-Commerce App'
    expect(page).to have_content 'Aeroporto SP'
    expect(page).to have_content 'GRU'
    expect(page).to have_content 'Guarulhos'
    expect(page).to have_content 'Rio'
    expect(page).to have_content 'SDU'
    expect(page).to have_content 'Rio de Janeiro'
  end

  it 'there are no warehouses' do
    # Arrange
    fake_response = double('faraday_response', status: 200, body: '[]')

    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses').and_return(fake_response)

    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Nenhum galpão encontrado'
  end

  it 'view warehouse details' do
    # Arrange
    json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses').and_return(fake_response)

    json_data = File.read(Rails.root.join('spec/support/json/warehouse.json'))
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses/1').and_return(fake_response)

    # Act
    visit root_path
    click_on 'Aeroporto SP'

    # Assert
    expect(page).to have_content 'Galpão GRU - Aeroporto SP'
    expect(page).to have_content 'Guarulhos'
    expect(page).to have_content '100000 m2'
    expect(page).to have_content 'Avenida do Aeroporto, 1000 - CEP: 15000-000'
    expect(page).to have_content 'Galpão destinado para cargas internacionais'
  end

  it 'unable to load warehouse' do
    # Arrange
    json_data = File.read(Rails.root.join('spec/support/json/warehouses.json'))
    fake_response = double('faraday_response', status: 200, body: json_data)
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses').and_return(fake_response)

    fake_response = double('faraday_response', status: 500, body: '{}')
    allow(Faraday).to receive(:get).with('http://localhost:3000/api/v1/warehouses/1').and_return(fake_response)

    # Act
    visit root_path
    click_on 'Aeroporto SP'

    # Assert
    expect(page).to have_content 'Não foi possível carregar o galpão'
    expect(current_path).to eq root_path
  end
end
