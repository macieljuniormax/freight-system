require 'rails_helper'

describe 'Usuário cadastra uma faixa de preços' do
  it 'se estiver autenticado' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Preços'

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
    click_on 'Tabela de Preços'
    click_on 'Cadastrar Preço'

    # Assert
    expect(page).to have_field('Volume mínimo') 
    expect(page).to have_field('Volume máximo') 
    expect(page).to have_field('Peso mínimo') 
    expect(page).to have_field('Peso máximo') 
    expect(page).to have_field('Preço por Km')
    expect(page).to have_button('Finalizar Cadastro') 
  end
  
  it "com sucesso" do
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
    click_on 'Tabela de Preços'
    click_on 'Cadastrar Preço'
    fill_in 'Volume mínimo',	with: 0.001
    fill_in 'Volume máximo',	with: 0.5 
    fill_in 'Peso mínimo',	with: 0
    fill_in 'Peso máximo',	with: 10 
    fill_in 'Preço por Km',	with: 0.5 
    click_on 'Finalizar Cadastro'

    # Assert
    expect(page).to have_content('Nova faixa de preço cadastrada com sucesso.') 
    expect(page).to have_content('Volume (m³)') 
    expect(page).to have_content('Peso') 
    expect(page).to have_content('Valor por Km') 
    expect(page).to have_content('0.001 a 0.5 m³') 
    expect(page).to have_content('0.0 a 10.0 Kg')
    expect(page).to have_content('R$ 0.5')
    price = Price.last
    expect(price.carrier.brand_name).to eq  'Next Transporte'
  end

  it 'com dados incompletos e falha' do
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
    click_on 'Tabela de Preços'
    click_on 'Cadastrar Preço'
    fill_in 'Volume mínimo',	with: 0.001
    fill_in 'Volume máximo',	with: ''
    fill_in 'Peso mínimo',	with: 0
    fill_in 'Peso máximo',	with: ''
    fill_in 'Preço por Km',	with: ''
    click_on 'Finalizar Cadastro'

    # Assert
    expect(page).to have_content('Faixa de preço não cadastrada.')
    expect(page).to have_content('Volume máximo não pode ficar em branco')
    expect(page).to have_content('Peso máximo não pode ficar em branco')
    expect(page).to have_content('Preço por Km não pode ficar em branco')
  end
end