require 'rails_helper'

describe 'Usuário edita um prazo' do
  it 'se estiver autenticado' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Tabela de Prazos'

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
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@nexttransport.com.br', password: 'password')
    Deadline.create!(min_distance: 0, max_distance: 100, deadline_days: 2, carrier: carrier)

    # Act
    login_as(user)
    visit root_path
    click_on 'Tabela de Prazos'
    click_on 'Editar'

    # Assert
    expect(page).to have_content('Editar Prazo')
    expect(page).to have_field('Distância mínima', with: 0)
    expect(page).to have_field('Distância máxima', with: 100)
    expect(page).to have_field('Prazo em dias', with: 2)
  end

  it 'com sucesso' do
    # Arrange
    carrier = Carrier.create!(corporate_name: 'Transportes Next LTDA', 
      brand_name: 'Next Transporte', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransport.com.br')
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@nexttransport.com.br', password: 'password')
    Deadline.create!(min_distance: 0, max_distance: 100, deadline_days: 2, carrier: carrier)

    # Act
    login_as(user)
    visit root_path
    click_on 'Tabela de Prazos'
    click_on 'Editar'
    fill_in 'Distância mínima', with: 1
    fill_in 'Distância máxima', with: 100
    fill_in 'Prazo em dias', with: 3
    click_on "Finalizar"

    # Assert
    expect(page).to have_content('Prazo atualizado com sucesso.') 
    expect(page).to have_content('Distância') 
    expect(page).to have_content('Prazo')
    expect(page).to have_content('1 a 100 Km') 
    expect(page).to have_content('3 dias')
    deadline = Deadline.last
    expect(deadline.carrier.brand_name).to eq 'Next Transporte'
  end
end
