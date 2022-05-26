require 'rails_helper'

describe 'Usuário se autentica' do
  it 'como admin com sucesso' do
    # Arrange 
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@sistemadefrete.com.br', password: 'password', )

    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'macieljunior@sistemadefrete.com.br'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    # Assert
    expect(page).to have_content 'Login efetuado com sucesso.'
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content "#{user.email}"
    end
  end

  it 'como admin sem sucesso' do
    # Arrange 
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@sistemadefrete.com.br', password: 'password')

    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'macieljunior@gmail.com'
      fill_in 'Senha', with: 'passwor'
      click_on 'Entrar'
    end

    # Assert
    expect(page).to have_content 'E-mail ou senha inválidos.'
    within('nav') do
      expect(page).to have_link 'Entrar'
      expect(page).not_to have_button 'Sair'
    end
  end
  
  it 'como user com sucesso' do
    # Arrange 
    Carrier.create!(corporate_name: 'Transportadora Next LTDA', 
      brand_name: 'Next Transportadora', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransportadora.com.br')
    
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@nexttransportadora.com.br', password: 'uasd-sdsc-sscs')

    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'macieljunior@nexttransportadora.com.br'
      fill_in 'Senha', with: 'uasd-sdsc-sscs'
      click_on 'Entrar'
    end

    # Assert
    expect(page).to have_content 'Login efetuado com sucesso.'
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content "#{user.email}"
    end
  end

  it 'como user sem sucesso' do
    # Arrange 
    Carrier.create!(corporate_name: 'Transportadora Next LTDA', 
      brand_name: 'Next Transportadora', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransportadora.com.br')
    
    user = User.create!(name: 'Maciel Ferreira', email: 'macieljunior@nexttransportadora.com.br', password: 'uasd-sdsc-sscs')

    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'macieljunior@nexttransportadora.com'
      fill_in 'Senha', with: 'uasd-sdsc-sscs'
      click_on 'Entrar'
    end

    # Assert
    expect(page).to have_content 'E-mail ou senha inválidos.'
    within('nav') do
      expect(page).to have_link 'Entrar'
      expect(page).not_to have_button 'Sair'
    end
  end
  
  it 'e faz logout' do
    # Arrange 
    User.create!(email: 'macieljunior@sistemadefrete.com.br', password: 'password')

    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'macieljunior@sistemadefrete.com.br'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Sair'

    # Assert
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_content 'macieljunior@sistemadefrete.com.br'
    expect(page).not_to have_button 'Sair'
  end
end