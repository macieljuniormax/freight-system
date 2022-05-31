require 'rails_helper'

describe 'Usuário aceita ordem de serviço' do
  it 'se estiver autenticado' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Ordens de Serviço'

    #Assert
    expect(current_path).to eq new_user_session_path
  end
  
  it 'a partir da página principal' do
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
                                     email_domain: 'transportesbrasil.com.br')
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@nexttransport.com.br', password: 'password')
    Order.create!(pickup_address: 'Avenida São João Del Rey 200, Jardim Vilas Boas, Lavras - MG', 
                          delivery_address:'Rua Afonso Pena 45, Vila Maria, Diadema - SP', 
                          height: 0.1, width: 0.2, length: 0.5, weight: 20, receiver_name: 'Rodrigo Calazans', 
                          carrier: first_carrier)

    # Act
    login_as(user)
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Aceitar Ordem de Serviço'

    # Assert
    expect(page).to have_content('Editar Transportadora')
    expect(page).to have_field('Nome Fantasia', with: 'Next Transporte')
    expect(page).to have_field('Razão Social', with: 'Transportes Next LTDA')
    expect(page).to have_field('CNPJ', with: '12.123.123/0001-01')
    expect(page).to have_field('Endereço', with: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG')
    expect(page).to have_field('Domínio de E-mail', with: 'nexttransport.com.br')
  end

  # it 'com sucesso' do
  #   # Arrange
  #   carrier = Carrier.create!(corporate_name: 'Transportes Next LTDA', 
  #     brand_name: 'Next Transporte', 
  #     registration_number: '12.123.123/0001-01', 
  #     address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
  #     email_domain: 'nexttransport.com.br')
  #   user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@sistemadefrete.com.br', password: 'password')

  #   # Act
  #   login_as(user)
  #   visit root_path
  #   click_on 'Transportadoras'
  #   click_on 'Next Transporte'
  #   click_on 'Editar'
  #   fill_in 'Nome Fantasia', with: 'Next Transportadora'
  #   fill_in 'Razão Social', with: 'Transportadoras Next LTDA'
  #   fill_in 'CNPJ', with: '12.123.123/0001-01'
  #   fill_in 'Endereço', with: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG'
  #   fill_in 'Domínio de E-mail', with: 'nexttransport.com.br'
  #   click_on "Finalizar"

  #   # Assert
  #   expect(page).to have_content('Transportadora atualizada com sucesso')
  #   expect(page).to have_content('Next Transportadora')
  #   expect(page).to have_content('Razão Social: Transportadoras Next LTDA')
  #   expect(page).to have_content('CNPJ: 12.123.123/0001-01')
  #   expect(page).to have_content('Endereço: Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG')
  #   expect(page).to have_content('Domínio de E-mail: nexttransport.com.br')
  # end

  # it 'Sem sucesso' do
  #   # Arrange
  #   carrier = Carrier.create!(corporate_name: 'Transportes Next LTDA', 
  #     brand_name: 'Next Transporte', 
  #     registration_number: '12.123.123/0001-01', 
  #     address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
  #     email_domain: 'nexttransport.com.br')
  #   user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@sistemadefrete.com.br', password: 'password')

  #   # Act
  #   login_as(user)
  #   visit root_path
  #   click_on 'Transportadoras'
  #   click_on 'Next Transporte'
  #   click_on 'Editar'
  #   fill_in 'Nome Fantasia', with: ''
  #   fill_in 'Razão Social', with: 'Transportadoras Next LTDA'
  #   fill_in 'CNPJ', with: '12.123.123/0001-01'
  #   fill_in 'Endereço', with: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG'
  #   fill_in 'Domínio de E-mail', with: 'nexttransport.com.br'
  #   click_on "Finalizar"

  #   # Assert
  #   expect(page).to have_content('Transportadora não atualizada.')
  # end
end
