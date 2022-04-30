require 'rails_helper'

RSpec.describe 'Payments', type: :system do
  it 'goes to payments page' do
    sign_in User.create!(name: 'Badman', email: 'meri@example.com', password: 'password')
    visit '/payments'
    expect(page).to have_content('PAYMENTS')
  end

  it 'goes to payment details' do
    user = User.create!(name: 'Badman', email: 'meri@example.com', password: 'password')
    sign_in user
    category = Category.create!(user:, name: 'Category #1',
                                icon: ActionController::Base.helpers.image_path('education.png'))
    payment = Payment.new(user:, name: 'Payment #1', amount: 731)
    payment.categories.push(category)
    payment.save
    visit "/payments/#{payment.id}"
    expect(page).to have_content(category.name)
    expect(page).to have_content(payment.name)
  end

  it 'creates new payment' do
    user = User.create!(name: 'Badman', email: 'meri@example.com', password: 'password')
    sign_in user
    category = Category.create!(user:, name: 'Category #1',
                                icon: ActionController::Base.helpers.image_path('education.png'))
    visit '/payments/new'
    fill_in 'payment_name', with: 'Transaction #1'
    fill_in 'payment_amount', with: 73
    find('#payment_categories option').select_option
    click_button 'CREATE PAYMENT'
    sleep(2)
    expect(page).to have_content(Payment.last.name)
    expect(page).to have_content(Payment.last.amount)
    expect(page).to have_content(category.name)
  end

  it 'goes to edit payment details page' do
    user = User.create!(name: 'Badman', email: 'meri@example.com', password: 'password')
    sign_in user
    category = Category.create!(user:, name: 'Category #1',
                                icon: ActionController::Base.helpers.image_path('education.png'))
    payment = Payment.new(user:, name: 'Payment #1', amount: 731)
    payment.categories.push(category)
    payment.save
    visit "/payments/#{payment.id}/edit"
    fill_in 'payment_name', with: 'Transaction #1'
    fill_in 'payment_amount', with: 73
    find('#payment_categories option').select_option
    click_button 'SUBMIT'
    sleep(4)
    expect(page).to have_content(Payment.last.name)
    expect(page).to have_content(Payment.last.amount)
    expect(page).to have_content(category.name)
  end

  it 'delete payment' do
    user = User.create!(name: 'Badman', email: 'meri@example.com', password: 'password')
    sign_in user
    category = Category.create!(user:, name: 'Category #1',
                                icon: ActionController::Base.helpers.image_path('education.png'))
    payment = Payment.new(user:, name: 'Payment #1', amount: 731)
    payment.categories.push(category)
    payment.save
    visit "/payments/#{payment.id}"
    click_button 'DESTROY'
    expect(page).to have_current_path(categories_path)
  end
end
