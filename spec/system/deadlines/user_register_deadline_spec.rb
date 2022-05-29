require 'rails_helper'

describe 'Usuário cadastra um prazo' do
  it 'se estiver autenticado' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Tabela de Prazos'

    #Assert
    expect(current_path).to eq new_user_session_path
  end

  it "a partir da tela inicial" do
    # Arrange
    carrier = Carrier.create!(corporate_name: 'Transportes Next LTDA', 
      brand_name: 'Next Transporte', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransport.com.br')
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@nexttransport.com.br', password: 'password', carrier:carrier)
    
    # Act
    login_as(user)
    visit root_path
    click_on 'Tabela de Prazos'
    click_on 'Cadastrar Prazo'

    # Assert
    expect(page).to have_field('Distância mínima') 
    expect(page).to have_field('Distância máxima') 
    expect(page).to have_field('Prazo em dias') 
    expect(page).to have_button('Finalizar Cadastro') 
  end
  
  it "com sucesso" do
    # Arrange
    carrier = Carrier.create!(corporate_name: 'Transportes Next LTDA', 
      brand_name: 'Next Transporte', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransport.com.br')
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@nexttransport.com.br', password: 'password')

    # Act
    login_as(user)
    visit root_path
    click_on 'Tabela de Prazos'
    click_on 'Cadastrar Prazo'
    fill_in 'Distância mínima',	with: 0
    fill_in 'Distância máxima',	with: 100 
    fill_in 'Prazo em dias',	with: 2
    click_on 'Finalizar Cadastro'

    # Assert
    expect(page).to have_content('Distância') 
    expect(page).to have_content('Prazo')
    expect(page).to have_content('0 a 100 Km') 
    expect(page).to have_content('2 dias')
    deadline = Deadline.last
    expect(deadline.carrier.brand_name).to eq  'Next Transporte'
  end

  it "com dados incompletos e falha" do
    # Arrange
    carrier = Carrier.create!(corporate_name: 'Transportes Next LTDA', 
      brand_name: 'Next Transporte', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransport.com.br')
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@nexttransport.com.br', password: 'password')

    # Act
    login_as(user)
    visit root_path
    click_on 'Tabela de Prazos'
    click_on 'Cadastrar Prazo'
    fill_in 'Distância mínima',	with: ""
    fill_in 'Distância máxima',	with: "" 
    fill_in 'Prazo em dias',	with: 2
    click_on 'Finalizar Cadastro'

    # Assert
    expect(page).to have_content('Novo prazo não cadastrado.')
    expect(page).to have_content('Distância mínima não pode ficar em branco')
    expect(page).to have_content('Distância máxima não pode ficar em branco')
  end
end