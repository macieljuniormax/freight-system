require 'rails_helper'

describe "Usuário vê transportadoras cadastradas" do
  it 'se estiver autenticado' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Veículos'

    #Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir do menu' do
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

    #Assert
    expect(current_path).to eq vehicles_path
  end

  it 'com sucesso' do
    # Arrage
    Carrier.create!(corporate_name: 'Transportes Next LTDA', 
      brand_name: 'Next Transporte', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransport.com.br')
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@nexttransport.com.br', password: 'password')
    veiculo = Vehicle.create!(plate: 'SKD-2525', brand_name: 'Volvo', model: 'S60', year_manufacture: 2022, capacity: 445)
    
    # Act 
    login_as(user)
    visit root_path
    click_on 'Veículos'

    # Assert
    expect(page).to have_content('Volvo')
    expect(page).to have_content('SKD-2525')
    expect(page).to have_content('S60')
    expect(page).to have_content('2022')
    expect(page).to have_content('445')
    expect(veiculo.carrier.brand_name).to eq 'Next Transporte'
  end

  it 'sem sucesso' do
    # Arrage
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

    # Assert
    expect(page).to have_content('Não existem veículos cadastrados.')
  end
end
