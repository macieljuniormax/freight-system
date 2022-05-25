require 'rails_helper'

describe "Administrador vê transportadoras cadastradas" do
  it 'a partir do menu' do
    # Arrange

    # Act
    visit root_path
    within('nav') do
      click_on 'Transportadoras'
    end

    #Assert
    expect(current_path).to eq carriers_path
  end

  it 'com sucesso' do
    # Arrage
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
    visit root_path
    click_on 'Transportadoras'

    # Assert
    expect(page).to have_content('Next Transporte')
    expect(page).to have_content('Transportes Next LTDA')
    expect(page).to have_content('Trans Parente')
    expect(page).to have_content('Trans Parente Brasil')
  end

  it 'sem sucesso' do
    # Arrage
    
    # Act 
    visit root_path
    click_on 'Transportadoras'

    # Assert
    expect(page).to have_content('Não existem transportadoras cadastradas.')
  end
end
