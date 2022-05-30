require 'rails_helper'

describe 'Usuário faz uma consulta' do
  it 'se estiver autenticado' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Consultas de Preço'

    #Assert
    expect(current_path).to eq new_user_session_path
  end

  it "a partir da tela inicial" do
    # Arrange
    carrier = Carrier.create!(corporate_name: 'Transportes Next LTDA', 
      brand_name: 'Next Transporte', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransport.com.br')
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@nexttransport.com.br', password: 'password', carrier:carrier)
    
    # Act
    login_as(user)
    visit root_path
    click_on 'Consultas de Preço'
    click_on 'Nova Consulta'

    # Assert
    expect(page).to have_field('Altura') 
    expect(page).to have_field('Largura') 
    expect(page).to have_field('Comprimento') 
    expect(page).to have_field('Peso') 
    expect(page).to have_field('Distância') 
    expect(page).to have_button('Buscar') 
  end
  
  it "com sucesso" do
    # Arrange
    first_carrier = Carrier.create!(corporate_name: 'Transportes Next LTDA', 
                                    brand_name: 'Next Transporte', 
                                    registration_number: '12.123.123/0001-01', 
                                    address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
                                    email_domain: 'nexttransporte.com.br')
    Deadline.create!(min_distance: 0, max_distance: 100, deadline_days: 2, carrier: first_carrier)
    Deadline.create!(min_distance: 101, max_distance: 200, deadline_days: 4, carrier: first_carrier)
    Deadline.create!(min_distance: 201, max_distance: 300, deadline_days: 6, carrier: first_carrier)
    Deadline.create!(min_distance: 301, max_distance: 400, deadline_days: 8, carrier: first_carrier)
    Price.create!(min_volume: 0.001, max_volume: 0.500, min_weight: 0, max_weight: 10, price_km: 0.5, carrier: first_carrier)
    Price.create!(min_volume: 0.001, max_volume: 0.500, min_weight: 10, max_weight: 30, price_km: 0.8, carrier: first_carrier)
    Price.create!(min_volume: 0.001, max_volume: 0.500, min_weight: 30, max_weight: 60, price_km: 1.0, carrier: first_carrier)
    Price.create!(min_volume: 0.501, max_volume: 1.000, min_weight: 0, max_weight: 10, price_km: 1.2, carrier: first_carrier)
    Price.create!(min_volume: 0.501, max_volume: 1.000, min_weight: 10, max_weight: 30, price_km: 1.4, carrier: first_carrier)
    Price.create!(min_volume: 0.501, max_volume: 1.000, min_weight: 30, max_weight: 60, price_km: 1.6, carrier: first_carrier)

    second_carrier = Carrier.create!(corporate_name: 'São Luiz Transportes SA', 
                                    brand_name: 'Transportadora São Luiz', 
                                    registration_number: '12.123.123/0001-02', 
                                    address: 'Avenida Brasil 1500, Centro, São Paulo - SP', 
                                    email_domain: 'sltransportes.com.br')
    Deadline.create!(min_distance: 0, max_distance: 100, deadline_days: 3, carrier: second_carrier)
    Deadline.create!(min_distance: 101, max_distance: 200, deadline_days: 4, carrier: second_carrier)
    Deadline.create!(min_distance: 201, max_distance: 300, deadline_days: 5, carrier: second_carrier)
    Deadline.create!(min_distance: 301, max_distance: 400, deadline_days: 9, carrier: second_carrier)
    Price.create!(min_volume: 0.001, max_volume: 0.500, min_weight: 0, max_weight: 10, price_km: 0.4, carrier: second_carrier)
    Price.create!(min_volume: 0.001, max_volume: 0.500, min_weight: 10, max_weight: 30, price_km: 0.6, carrier: second_carrier)
    Price.create!(min_volume: 0.001, max_volume: 0.500, min_weight: 30, max_weight: 60, price_km: 1.0, carrier: second_carrier)
    Price.create!(min_volume: 0.501, max_volume: 1.000, min_weight: 0, max_weight: 10, price_km: 1.3, carrier: second_carrier)
    Price.create!(min_volume: 0.501, max_volume: 1.000, min_weight: 10, max_weight: 30, price_km: 1.5, carrier: second_carrier)
    Price.create!(min_volume: 0.501, max_volume: 1.000, min_weight: 30, max_weight: 60, price_km: 2.0, carrier: second_carrier)
  
  admin = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@sistemadefrete.com.br', password: 'password')
    # Act
    login_as(admin)
    visit root_path
    click_on 'Consultas de Preço'
    fill_in 'Altura',	with: 0.1
    fill_in 'Largura',	with: 0.2
    fill_in 'Comprimento',	with: 0.3
    fill_in 'Peso',	with: 20
    fill_in 'Distância',	with: 300
    click_on 'Buscar'

    # Assert
    expect(page).to have_content('Next Transporte') 
    expect(page).to have_content('6 dias') 
    expect(page).to have_content('R$ 240.0') 
    expect(page).to have_content('Transportadora São Luiz') 
    expect(page).to have_content('5 dias') 
    expect(page).to have_content('R$ 180.0') 
    expect(page).to have_content('Transportadora São Luiz') 
    
    
  end

  # it 'com dados incompletos e falha' do
  #    # Arrange
  #    carrier = Carrier.create!(corporate_name: 'Transportes Next LTDA', 
  #     brand_name: 'Next Transporte', 
  #     registration_number: '12.123.123/0001-01', 
  #     address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
  #     email_domain: 'nexttransport.com.br')
  #   user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@nexttransport.com.br', password: 'password', carrier:carrier)

  #   # Act
  #   login_as(user)
  #   visit root_path
  #   click_on 'Tabela de Preços'
  #   click_on 'Cadastrar Preço'
  #   fill_in 'Volume mínimo',	with: 0.001
  #   fill_in 'Volume máximo',	with: ''
  #   fill_in 'Peso mínimo',	with: 0
  #   fill_in 'Peso máximo',	with: ''
  #   fill_in 'Preço por Km',	with: ''
  #   click_on 'Finalizar Cadastro'

  #   # Assert
  #   expect(page).to have_content('Faixa de preço não cadastrada.')
  #   expect(page).to have_content('Volume máximo não pode ficar em branco')
  #   expect(page).to have_content('Peso máximo não pode ficar em branco')
  #   expect(page).to have_content('Preço por Km não pode ficar em branco')
  # end
end