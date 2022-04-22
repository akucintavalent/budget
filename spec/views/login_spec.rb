require 'rails_helper'

RSpec.describe 'Login', type: :system do
  it 'shows the login page' do
    visit '/users/sign_in'
    expect(page).to have_content('LOGGING IN')
  end

  it 'inputs proper credentials' do
    visit '/users/sign_in'
    User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    fill_in 'user_email', with: 'bogdan@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'
    expect(page).to have_current_path(categories_path)
  end
end