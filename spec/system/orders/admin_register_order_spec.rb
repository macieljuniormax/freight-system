require 'rails_helper'

describe 'Administrador cadastra uma transportadora' do
  it 'se estiver autenticado' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Ordens de Serviço'

    #Assert
    expect(current_path).to eq new_user_session_path
  end
  
  it "a partir da tela inicial" do
    # Arrange
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@sistemadefrete.com.br', password: 'password')
    
    
    # Act
    login_as(user)
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Criar Ordem de Serviço'

    # Assert
    expect(page).to have_field('Endereço de Retirada') 
    expect(page).to have_field('Endereço do Destinatário') 
    expect(page).to have_field('Altura') 
    expect(page).to have_field('Altura') 
    expect(page).to have_field('Largura') 
    expect(page).to have_field('Peso') 
    expect(page).to have_field('Nome do Destinatário') 
  end

  it 'com sucesso' do
    # Arrange
    first_carrier = Carrier.create!(corporate_name: 'Transportes Next LTDA', 
      brand_name: 'Next Transporte', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransport.com.br')
    second_carrier = Carrier.create!(corporate_name: 'Transportes Brasil SSA', 
      brand_name: 'Transportes Brasil', 
      registration_number: '12.123.123/0001-02', 
      address: 'Avenida Vereador Antônio, Jardim Pouso Alto, Arceburgo - MG', 
      email_domain: 'nexttransport.com.br')
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@sistemadefrete.com.br', password: 'password')

    # Act
    login_as(user)
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Criar Ordem de Serviço'
    fill_in 'Endereço de Retirada',	with: 'Avenida São João Del Rey 200, Jardim Vilas Boas, Lavras - MG' 
    fill_in 'Endereço do Destinatário',	with: 'Rua Afonso Pena 45, Vila Maria, Diadema - SP' 
    fill_in 'Altura',	with: 0.1 
    fill_in 'Largura',	with: 0.2
    fill_in "Comprimento",	with: 0.5 
    fill_in 'Peso',	with: 6
    fill_in 'Nome do Destinatário',	with: 'Rodrigo Calazans' 
    select second_carrier.brand_name, from: 'Transportadora'
    click_on 'Finalizar Cadastro'

    # Assert
    expect(page).to have_content('Ordem cadastrada com sucesso.')
    expect(page).to have_content(second_carrier.brand_name) 
    expect(page).to have_content('Endereço de Retirada: Avenida São João Del Rey 200, Jardim Vilas Boas, Lavras - MG') 
    expect(page).to have_content('Endereço do Destinatário: Rua Afonso Pena 45, Vila Maria, Diadema - SP') 
    expect(page).to have_content('Altura: 0.1m') 
    expect(page).to have_content('Largura: 0.2m') 
    expect(page).to have_content('Comprimento: 0.5m') 
    expect(page).to have_content('Peso: 6.0Kg') 
    expect(page).to have_content('Nome do Destinatário: Rodrigo Calazans') 
    expect(page).to have_content('Status: Pendente') 
  end

  it 'com dados incompletos' do
     # Arrange
     first_carrier = Carrier.create!(corporate_name: 'Transportes Next LTDA', 
      brand_name: 'Next Transporte', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransport.com.br')
    second_carrier = Carrier.create!(corporate_name: 'Transportes Brasil SSA', 
      brand_name: 'Transportes Brasil', 
      registration_number: '12.123.123/0001-02', 
      address: 'Avenida Vereador Antônio, Jardim Pouso Alto, Arceburgo - MG', 
      email_domain: 'nexttransport.com.br')
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@sistemadefrete.com.br', password: 'password')

    # Act
    login_as(user)
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Criar Ordem de Serviço'
    fill_in 'Endereço de Retirada',	with: 'Avenida São João Del Rey 200, Jardim Vilas Boas, Lavras - MG' 
    fill_in 'Endereço do Destinatário',	with: 'Rua Afonso Pena 45, Vila Maria, Diadema - SP' 
    fill_in 'Altura',	with: '' 
    fill_in 'Largura',	with: ''
    fill_in "Comprimento",	with: 0.5 
    fill_in 'Peso',	with: 6
    fill_in 'Nome do Destinatário',	with: 'Rodrigo Calazans' 
    select second_carrier.brand_name, from: 'Transportadora'
    click_on 'Finalizar Cadastro'

    # Assert
    expect(page).to have_content('Ordem não cadastrada.')
    expect(page).to have_content('Altura não pode ficar em branco')
    expect(page).to have_content('Largura não pode ficar em branco')
  end
end