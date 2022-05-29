require 'rails_helper'

describe 'Administrador edita uma transportadora' do
  it 'se estiver autenticado' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Transportadoras'

    #Assert
    expect(current_path).to eq new_user_session_path
  end
  
  it 'a partir da página principal' do
    # Arrange
    carrier = Carrier.create!(corporate_name: 'Transportes Next LTDA', 
      brand_name: 'Next Transporte', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransport.com.br')
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@sistemadefrete.com.br', password: 'password')

    # Act
    login_as(user)
    visit root_path
    click_on 'Transportadoras'
    click_on 'Next Transporte'
    click_on 'Editar'

    # Assert
    expect(page).to have_content('Editar Transportadora')
    expect(page).to have_field('Nome Fantasia', with: 'Next Transporte')
    expect(page).to have_field('Razão Social', with: 'Transportes Next LTDA')
    expect(page).to have_field('CNPJ', with: '12.123.123/0001-01')
    expect(page).to have_field('Endereço', with: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG')
    expect(page).to have_field('Domínio de E-mail', with: 'nexttransport.com.br')
  end

  it 'com sucesso' do
    # Arrange
    carrier = Carrier.create!(corporate_name: 'Transportes Next LTDA', 
      brand_name: 'Next Transporte', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransport.com.br')
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@sistemadefrete.com.br', password: 'password')

    # Act
    login_as(user)
    visit root_path
    click_on 'Transportadoras'
    click_on 'Next Transporte'
    click_on 'Editar'
    fill_in 'Nome Fantasia', with: 'Next Transportadora'
    fill_in 'Razão Social', with: 'Transportadoras Next LTDA'
    fill_in 'CNPJ', with: '12.123.123/0001-01'
    fill_in 'Endereço', with: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG'
    fill_in 'Domínio de E-mail', with: 'nexttransport.com.br'
    click_on "Finalizar"

    # Assert
    expect(page).to have_content('Transportadora atualizada com sucesso')
    expect(page).to have_content('Next Transportadora')
    expect(page).to have_content('Razão Social: Transportadoras Next LTDA')
    expect(page).to have_content('CNPJ: 12.123.123/0001-01')
    expect(page).to have_content('Endereço: Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG')
    expect(page).to have_content('Domínio de E-mail: nexttransport.com.br')
  end

  it 'Sem sucesso' do
    # Arrange
    carrier = Carrier.create!(corporate_name: 'Transportes Next LTDA', 
      brand_name: 'Next Transporte', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransport.com.br')
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@sistemadefrete.com.br', password: 'password')

    # Act
    login_as(user)
    visit root_path
    click_on 'Transportadoras'
    click_on 'Next Transporte'
    click_on 'Editar'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: 'Transportadoras Next LTDA'
    fill_in 'CNPJ', with: '12.123.123/0001-01'
    fill_in 'Endereço', with: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG'
    fill_in 'Domínio de E-mail', with: 'nexttransport.com.br'
    click_on "Finalizar"

    # Assert
    expect(page).to have_content('Transportadora não atualizada.')
  end
end
