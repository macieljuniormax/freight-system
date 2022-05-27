require 'rails_helper'

describe 'Usuário vê detalhes da transportadora' do
  it 'a partir da tela inicial' do
    # Arrage
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@sistemadefrete.com.br', password: 'password')
    Carrier.create!(corporate_name: 'Transportes Next LTDA', 
      brand_name: 'Next Transporte', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransport.com.br')

    # Act 
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Transportadoras'
    end
    click_on 'Next Transporte'
    
    # Assert
    expect(page).to have_content('Next Transporte') 
    expect(page).to have_content('Razão Social: Transportes Next LTDA') 
    expect(page).to have_content('Domínio de E-mail: nexttransport.com.br') 
    expect(page).to have_content('CNPJ: 12.123.123/0001-01') 
    expect(page).to have_content('Endereço: Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG')

  end

  it 'e volta para transportadoras cadastradas' do
    # Arrage
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@sistemadefrete.com.br', password: 'password')
    Carrier.create!(corporate_name: 'Transportes Next LTDA', 
      brand_name: 'Next Transporte', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransport.com.br')

    # Act 
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Transportadoras'
    end
    click_on 'Next Transporte'
    click_on 'Voltar'
    
    # Assert
    expect(current_path).to eq carriers_path
  end
end