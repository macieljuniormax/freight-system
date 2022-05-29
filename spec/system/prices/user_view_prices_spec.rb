require 'rails_helper'

describe 'Usuário vê preços' do
  it 'se estiver autenticado' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Tabela de Preços'

    #Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir da tela inicial' do
    # Arrage
    carrier = Carrier.create!(corporate_name: 'Transportes Next LTDA', 
      brand_name: 'Next Transporte', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransport.com.br')
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@nexttransport.com.br', password: 'password')
    Price.create!(min_volume: 0.001, max_volume: 0.500, min_weight: 0, max_weight: 10, price_km: 0.5, carrier: carrier)
    Price.create!(min_volume: 0.001, max_volume: 0.500, min_weight: 10, max_weight: 30, price_km: 0.8, carrier: carrier)
    Price.create!(min_volume: 0.001, max_volume: 0.500, min_weight: 30, max_weight: 60, price_km: 1.0, carrier: carrier)
    Price.create!(min_volume: 0.501, max_volume: 1.000, min_weight: 0, max_weight: 10, price_km: 1.2, carrier: carrier)
    Price.create!(min_volume: 0.501, max_volume: 1.000, min_weight: 10, max_weight: 30, price_km: 1.4, carrier: carrier)
    Price.create!(min_volume: 0.501, max_volume: 1.000, min_weight: 30, max_weight: 60, price_km: 1.6, carrier: carrier)

    # Act 
    login_as(user)
    visit root_path
    click_on 'Tabela de Preços'
    
    # Assert
    expect(page).to have_content('Volume (m³)') 
    expect(page).to have_content('Peso') 
    expect(page).to have_content('Valor por Km') 
    expect(page).to have_content('0.001 a 0.5 m³') 
    expect(page).to have_content('0.0 a 10.0 Kg')
    expect(page).to have_content('R$ 0.5')

  end

  it 'e volta para o menu' do
    # Arrage
    carrier = Carrier.create!(corporate_name: 'Transportes Next LTDA', 
      brand_name: 'Next Transporte', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransport.com.br')
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@nexttransport.com.br', password: 'password')
    Price.create!(min_volume: 0.001, max_volume: 0.500, min_weight: 0, max_weight: 10, price_km: 0.5, carrier: carrier)
    Price.create!(min_volume: 0.001, max_volume: 0.500, min_weight: 10, max_weight: 30, price_km: 0.8, carrier: carrier)
    Price.create!(min_volume: 0.001, max_volume: 0.500, min_weight: 30, max_weight: 60, price_km: 1.0, carrier: carrier)
    Price.create!(min_volume: 0.501, max_volume: 1.000, min_weight: 0, max_weight: 10, price_km: 1.2, carrier: carrier)
    Price.create!(min_volume: 0.501, max_volume: 1.000, min_weight: 10, max_weight: 30, price_km: 1.4, carrier: carrier)
    Price.create!(min_volume: 0.501, max_volume: 1.000, min_weight: 30, max_weight: 60, price_km: 1.6, carrier: carrier)

    # Act 
    login_as(user)
    visit root_path
    click_on 'Tabela de Preços'
    click_on 'Voltar'
    
    # Assert
    expect(current_path).to eq root_path
  end
end