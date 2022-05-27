require 'rails_helper'

describe "Administrador vê transportadoras cadastradas" do
  it 'se estiver autenticado' do
    # Arrange
    
    # Act
    visit root_path
    within('nav') do
      click_on 'Transportadoras'
    end

    #Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir do menu' do
    # Arrange
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@sistemadefrete.com.br', password: 'password')
    
    # Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Transportadoras'
    end

    #Assert
    expect(current_path).to eq carriers_path
  end

  it 'com sucesso' do
    # Arrage
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@sistemadefrete.com.br', password: 'password')
    Carrier.create!(corporate_name: 'Transportes Next LTDA', 
                    brand_name: 'Next Transporte', 
                    registration_number: '12.123.123/0001-01', 
                    address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
                    email_domain: 'nexttransport.com.br')
    Carrier.create!(corporate_name: 'Trans Parente Brasil', 
                    brand_name: 'Trans Parente', 
                    registration_number: '12.123.123/0001-05', 
                    address: 'Avenida Camarões 175, Jardim Oliveiras, Guaxupé - MG', 
                    email_domain: 'nexttransport.com.br')
    
    # Act 
    login_as(user)
    visit root_path
    click_on 'Transportadoras'

    # Assert
    expect(page).to have_content('Next Transporte')
    expect(page).to have_content('Transportes Next LTDA')
    expect(page).to have_content('active')
    expect(page).to have_content('Trans Parente')
    expect(page).to have_content('Trans Parente Brasil')
    expect(page).to have_content('active')
  end

  it 'sem sucesso' do
    # Arrage
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@sistemadefrete.com.br', password: 'password')
    
    # Act 
    login_as(user)
    visit root_path
    click_on 'Transportadoras'

    # Assert
    expect(page).to have_content('Não existem transportadoras cadastradas.')
  end
end
