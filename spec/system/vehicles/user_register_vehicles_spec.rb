require 'rails_helper'

describe 'Usuário cadastra um veículo' do
  it "a partir da tela inicial" do
    # Arrange
    Carrier.create!(corporate_name: 'Transportes Next LTDA', 
      brand_name: 'Next Transporte', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransport.com.br')
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@nexttransport.com.br', password: 'password')
    
    
    # Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar Veículo'

    # Assert
    expect(page).to have_field('Marca') 
    expect(page).to have_field('Modelo') 
    expect(page).to have_field('Placa') 
    expect(page).to have_field('Ano de Fabricação') 
    expect(page).to have_field('Capacidade')
    expect(page).to have_button('Finalizar Cadastro') 
  end

  it 'com sucesso' do
    # Arrange
    Carrier.create!(corporate_name: 'Transportes Next LTDA', 
      brand_name: 'Next Transporte', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransport.com.br')
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@nexttransport.com.br', password: 'password')

    # Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar Veículo'
    fill_in 'Marca',	with: 'Jeep' 
    fill_in 'Modelo',	with: 'Renegade Sport 1.3' 
    fill_in 'Placa',	with: 'NPX-2569' 
    fill_in 'Ano de Fabricação',	with: '2022' 
    fill_in 'Capacidade',	with: '400' 
    click_on 'Finalizar Cadastro'

    # Assert
    expect(page).to have_content('Jeep')
    expect(page).to have_content('Renegade Sport 1.3')
    expect(page).to have_content('NPX-2569')
    expect(page).to have_content('2022')
    expect(page).to have_content('400')
    vehicle = Vehicle.last
    expect(vehicle.carrier.brand_name).to eq 'Next Transporte'
  end

  it 'com dados incompletos e falha' do
    # Arrange
    Carrier.create!(corporate_name: 'Transportes Next LTDA', 
      brand_name: 'Next Transporte', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransport.com.br')
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@nexttransport.com.br', password: 'password')
   
    # Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar Veículo'
    fill_in 'Marca',	with: 'Jeep' 
    fill_in 'Modelo',	with: '' 
    fill_in 'Placa',	with: '' 
    fill_in 'Ano de Fabricação',	with: '' 
    fill_in 'Capacidade',	with: '400' 
    click_on 'Finalizar Cadastro'

    # Assert
    expect(page).to have_content('Veículo não cadastrado.')
    expect(page).to have_content('Modelo não pode ficar em branco')
    expect(page).to have_content('Placa não pode ficar em branco')
    expect(page).to have_content('Ano de Fabricação não pode ficar em branco')
  end
end