require 'rails_helper'

describe 'User view homepage' do
  it 'views warehouses' do
    # Arrange 

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
end
