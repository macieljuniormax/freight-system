require 'rails_helper'

describe 'Usuário visita tela inicial' do
  it 'e vê o nome da aplicação' do
    # Arrange

    # Act
    visit root_path

    # Assert
    expect(page).to have_content('MaxFrete') 
    expect(page).to have_link('MaxFrete', href: root_path) 
  end
end