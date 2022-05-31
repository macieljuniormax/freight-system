require 'rails_helper'

describe 'Usuário as ordens de serviço da sua transportadora' do
  it 'se estiver autenticado' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Ordens de Serviço'

    #Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê de outras transportadoras' do
    # Arrage
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
                          height: 0.1, width: 0.2, length: 0.5, weight: 20, receiver_name: 'Joana Morais', 
                          carrier: first_carrier)
    Order.create!(pickup_address: 'Avenida São João Del Rey 200, Jardim Vilas Boas, Lavras - MG', 
                          delivery_address:'Rua Afonso Pena 45, Vila Maria, Diadema - SP', 
                          height: 0.1, width: 0.2, length: 0.5, weight: 20, receiver_name: 'Rodrigo Calazans', 
                          carrier: first_carrier)
    Order.create!(pickup_address: 'Avenida São João Del Rey 200, Jardim Vilas Boas, Lavras - MG', 
                          delivery_address:'Rua Afonso Pena 45, Vila Maria, Diadema - SP', 
                          height: 0.1, width: 0.2, length: 0.5, weight: 20, receiver_name: 'Maciel Júnior', 
                          carrier: second_carrier)

    # Act 
    login_as(user)
    visit root_path
    click_on 'Ordens de Serviço'
    
    # Assert
    expect(page).to have_content('Joana Morais')
    expect(page).to have_content('Rodrigo Calazans')
    expect(page).to have_content('Next Transporte') 
    expect(page).to have_content('Pendente') 
    expect(page).not_to have_content('Maciel Júnior')
    expect(page).not_to have_content('Transportes Brasil')
  end
end