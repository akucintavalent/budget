require 'rails_helper'

RSpec.describe 'Categories', type: :system do
  it 'goes to categories page' do
    sign_in User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    visit '/categories'
    expect(page).to have_content('CATEGORIES')
  end

  it 'goes to category page' do
    user = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    category = Category.create!(user:, name: 'Category #1',
                                icon: ActionController::Base.helpers.image_path('education.png'))
    sign_in user
    visit "/categories/#{category.id}"
    expect(page).to have_content(category.name)
  end

  it 'creates a new category' do
    sign_in User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    visit '/categories/new'
    fill_in 'category_name', with: 'Category #n'
    find(:css, '#category_icon').find(:option, 'Shopping').select_option
    click_button 'CREATE CATEGORY'
    expect(page).to have_content('Category #n')
  end

  it 'edits category' do
    user = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    category = Category.create!(user:, name: 'Category #1',
                                icon: ActionController::Base.helpers.image_path('education.png'))
    sign_in user
    visit "/categories/#{category.id}/edit"
    fill_in 'category_name', with: 'Category ###', fill_options: { clear: :backspace }
    find(:css, '#category_icon').find(:option, 'Other').select_option
    click_button 'SUBMIT'
    expect(page).to have_content('Category ###')
  end

  it 'removes category' do
    user = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    category = Category.create!(user:, name: 'Category #1',
                                icon: ActionController::Base.helpers.image_path('education.png'))
    sign_in user
    visit "/categories/#{category.id}"
    click_button 'DESTROY'
    expect(page).to have_content('CATEGORIES')
  end
end
