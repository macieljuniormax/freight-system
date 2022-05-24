require 'rails_helper'

describe 'Administrador cadastra uma transportadora' do
  it "a partir da tela inicial" do
    # Arrange
  
    
    # Act
    visit root_path
    within('nav') do
      click_on 'Cadastrar Transportadora'
    end

    # Assert
    expect(page).to have_field('Nome Fantasia') 
    expect(page).to have_field('Razão Social') 
    expect(page).to have_field('Domínio de E-mail') 
    expect(page).to have_field('CNPJ') 
    expect(page).to have_field('Endereço') 
    expect(page).to have_button('Finalizar Cadastro') 
  end

  it 'com sucesso' do
    # Arrange

    # Act
    visit root_path
    within('nav') do
      click_on 'Cadastrar Transportadora'
    end
    fill_in 'Nome Fantasia',	with: 'Next Transporte' 
    fill_in 'Razão Social',	with: 'Transportes Next LTDA' 
    fill_in 'Domínio de E-mail',	with: 'nexttransport.com.br' 
    fill_in 'CNPJ',	with: '12.123.123/0001-12' 
    fill_in 'Endereço',	with: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG' 
    click_on 'Finalizar Cadastro'

    # Assert
    expect(page).to have_content('Transportadora cadastrada com sucesso.')
    expect(page).to have_content('Next Transporte') 
    expect(page).to have_content('Razão Social: Transportes Next LTDA') 
    expect(page).to have_content('Domínio de E-mail: nexttransport.com.br') 
    expect(page).to have_content('CNPJ: 12.123.123/0001-12') 
    expect(page).to have_content('Endereço: Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG')
  end

  it 'com dados incompletos' do
    # Arrange

    # Act
    visit root_path
    within('nav') do
      click_on 'Cadastrar Transportadora'
    end
    fill_in 'Nome Fantasia',	with: '' 
    fill_in 'Razão Social',	with: 'Transportes Next LTDA' 
    fill_in 'Domínio de E-mail',	with: 'nexttransport.com.br' 
    fill_in 'CNPJ',	with: '' 
    fill_in 'Endereço',	with: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG' 
    click_on 'Finalizar Cadastro'

    # Assert
    expect(page).to have_content('Transportadora não cadastrada.')
    expect(page).to have_content('Nome Fantasia não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
  end
end