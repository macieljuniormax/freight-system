require 'rails_helper'

describe 'Usuário visita tela inicial' do
  it 'e vê o nome da aplicação' do
    # Arrange

    # Act
    visit root_path

    # Assert
    expect(page).to have_content('MaxFrete') 
  end
end