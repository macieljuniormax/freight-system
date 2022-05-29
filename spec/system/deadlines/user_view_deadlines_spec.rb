require 'rails_helper'

describe 'Usuário vê preços' do
  it 'se estiver autenticado' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Tabela de Prazos'

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
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@nexttransport.com.br', password: 'password', carrier: carrier)
    Deadline.create!(min_distance: 0, max_distance: 100, deadline_days: 2, carrier: carrier)
    Deadline.create!(min_distance: 101, max_distance: 200, deadline_days: 4, carrier: carrier)
    Deadline.create!(min_distance: 201, max_distance: 300, deadline_days: 6, carrier: carrier)
    Deadline.create!(min_distance: 301, max_distance: 400, deadline_days: 8, carrier: carrier)

    # Act 
    login_as(user)
    visit root_path
    click_on 'Tabela de Prazos'
    
    # Assert
    expect(page).to have_content('Distância') 
    expect(page).to have_content('Prazo')
    expect(page).to have_content('0 a 100 Km') 
    expect(page).to have_content('101 a 200 Km') 
    expect(page).to have_content('201 a 300 Km') 
    expect(page).to have_content('301 a 400 Km') 
    expect(page).to have_content('2 dias')
    expect(page).to have_content('4 dias')
    expect(page).to have_content('6 dias')
    expect(page).to have_content('8 dias')

  end

  it 'e volta para o menu' do
    # Arrage
    carrier = Carrier.create!(corporate_name: 'Transportes Next LTDA', 
      brand_name: 'Next Transporte', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransport.com.br')
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@nexttransport.com.br', password: 'password', carrier: carrier)
    Deadline.create!(min_distance: 0, max_distance: 100, deadline_days: 2, carrier: carrier)
    Deadline.create!(min_distance: 101, max_distance: 200, deadline_days: 4, carrier: carrier)
    Deadline.create!(min_distance: 201, max_distance: 300, deadline_days: 6, carrier: carrier)
    Deadline.create!(min_distance: 201, max_distance: 400, deadline_days: 8, carrier: carrier)

    # Act 
    login_as(user)
    visit root_path
    click_on 'Tabela de Prazos'
    click_on 'Voltar'
    
    # Assert
    expect(current_path).to eq root_path
  end
end