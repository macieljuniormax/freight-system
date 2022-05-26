require 'rails_helper'

describe 'Usuário se cadastra' do
  it 'como admin com sucesso' do
    # Arrange 

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar Conta'
    fill_in 'Nome', with: 'Maciel Júnior'
    fill_in 'E-mail', with: 'maciel@sistemadefrete.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar Conta'

    # Assert
    expect(page).to have_content 'Boas Vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'maciel@sistemadefrete.com.br'
    expect(page).to have_button 'Sair'
    user = User.last
    expect(user.name).to eq 'Maciel Júnior'
    expect(user.admin).to eq true
  end

  it 'como admin e falha' do
    # Arrange 

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar Conta'
    fill_in 'Nome', with: 'Maciel Júnior'
    fill_in 'E-mail', with: 'maciel@sistemadefrete.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar Conta'

    # Assert
    expect(page).to have_content 'Não foi possível salvar usuário'
    expect(page).to have_content 'E-mail não é válido'
  end

  it 'como user com sucesso' do
    # Arrange 
    Carrier.create!(corporate_name: 'Transportadora Next LTDA', 
      brand_name: 'Next Transportadora', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransportadora.com.br')

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar Conta'
    fill_in 'Nome', with: 'Maciel Júnior'
    fill_in 'E-mail', with: 'maciel@nexttransportadora.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar Conta'

    # Assert
    expect(page).to have_content 'Boas Vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'maciel@nexttransportadora.com.br'
    expect(page).to have_button 'Sair'
    user = User.last
    expect(user.name).to eq 'Maciel Júnior'
    expect(user.admin).to eq false
    expect(user.carrier.brand_name).to eq 'Next Transportadora'
    expect(user.carrier.registration_number).to eq '12.123.123/0001-01'
  end

  it 'como user e falha' do
    # Arrange 
    Carrier.create!(corporate_name: 'Transportadora Next LTDA', 
      brand_name: 'Next Transportadora', 
      registration_number: '12.123.123/0001-01', 
      address: 'Avenida Tiradentes 1500, Jardim São Sebastião, Lavras - MG', 
      email_domain: 'nexttransportadora.com.br')

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar Conta'
    fill_in 'Nome', with: 'Maciel Júnior'
    fill_in 'E-mail', with: 'maciel@brasiltransporte.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar Conta'

    # Assert
    expect(page).to have_content 'Não foi possível salvar usuário'
    expect(page).to have_content 'E-mail não é válido'
  end
end